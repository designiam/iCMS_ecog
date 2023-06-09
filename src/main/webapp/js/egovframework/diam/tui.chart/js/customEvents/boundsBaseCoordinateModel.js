/**
 * @fileoverview BoundsBaseCoordinateModel is data mode for custom event of point type.
 * @author NHN Ent.
 *         FE Development Lab <dl_javascript@nhnent.com>
 */

'use strict';

/**
 * position
 * @typedef {{left: number, top: number}} position
 */

/**
 * bound
 * @typedef {{
 *      dimension: {width: number, height: number},
 *      position: position
 *}} bound
 */

/**
 * group bound
 *  @typedef {Array.<Array.<bound>>} groupBound
 */

/**
 * group position
 *  @typedef {Array.<Array.<position>>} groupPosition
 */

/**
 * series info
 * @typedef {{
 *      chartType: {string},
 *      data: {
 *          groupBounds: ?groupBound,
 *          groupValues: ?Array.<Array.<number>>,
 *          groupPositions: ?groupPosition
 *      }
 *}} seriesInfo
 */

var chartConst = require('../const'),
    predicate = require('../helpers/predicate');

var BoundsBaseCoordinateModel = tui.util.defineClass(/** @lends BoundsBaseCoordinateModel.prototype */ {
    /**
     * BoundsBaseCoordinateModel is data mode for custom event of point type.
     * @constructs BoundsBaseCoordinateModel
     * @param {Array.<seriesInfo>} seriesInfos series infos
     */
    init: function(seriesInfos) {
        this.data = this._makeData(seriesInfos);
    },

    /**
     * Make coordinate data about bar type graph
     * @param {groupBound} groupBounds group bounds
     * @param {string} chartType chart type
     * @returns {Array} coordinate data
     * @private
     */
    _makeRectTypeCoordinateData: function(groupBounds, chartType) {
        var allowNegativeTooltip = !predicate.isBoxTypeChart(chartType);

        return tui.util.map(groupBounds, function(bounds, groupIndex) {
            return tui.util.map(bounds, function(_bound, index) {
                var bound;
                if (!_bound) {
                    return null;
                }

                bound = _bound.end;

                return {
                    sendData: {
                        chartType: chartType,
                        indexes: {
                            groupIndex: groupIndex,
                            index: index
                        },
                        allowNegativeTooltip: allowNegativeTooltip,
                        bound: bound
                    },
                    bound: {
                        left: bound.left,
                        top: bound.top,
                        right: bound.left + bound.width,
                        bottom: bound.top + bound.height
                    }
                };
            });
        });
    },

    /**
     * Make coordinate data about dot type graph
     * @param {groupPositions} groupPositions group positions
     * @param {string} chartType chart type
     * @returns {Array.<Array.<object>>} coordinate data
     * @private
     */
    _makeDotTypeCoordinateData: function(groupPositions, chartType) {
        if (!groupPositions) {
            return [];
        }

        return tui.util.map(tui.util.pivot(groupPositions), function(positions, groupIndex) {
            return tui.util.map(positions, function(position, index) {
                return {
                    sendData: {
                        chartType: chartType,
                        indexes: {
                            groupIndex: groupIndex,
                            index: index
                        },
                        bound: position
                    },
                    bound: {
                        left: position.left - chartConst.DOT_RADIUS,
                        top: position.top - chartConst.DOT_RADIUS,
                        right: position.left + chartConst.DOT_RADIUS,
                        bottom: position.top + chartConst.DOT_RADIUS
                    }
                };
            });
        });
    },

    /**
     * Join data.
     * @param {Array.<Array.<Array.<object>>>} groupData group data
     * @returns {Array.<Array.<object>>} joined data
     * @private
     */
    _joinData: function(groupData) {
        var results = [];
        tui.util.forEachArray(groupData, function(coordData) {
            tui.util.forEachArray(coordData, function(data, index) {
                if (!results[index]) {
                    results[index] = [];
                }
                results[index] = results[index].concat(data);
            });
        });

        return results;
    },

    /**
     * Make coordinate data.
     * @param {Array.<seriesInfo>} seriesInfos series infos
     * @returns {Array.<Array.<object>>} coordinate data
     * @private
     */
    _makeData: function(seriesInfos) {
        var self = this,
            coordinateData;

        seriesInfos.reverse();
        coordinateData = tui.util.map(seriesInfos, function(info) {
            var result;
            if (predicate.isLineTypeChart(info.chartType)) {
                result = self._makeDotTypeCoordinateData(info.data.groupPositions, info.chartType);
            } else {
                result = self._makeRectTypeCoordinateData(info.data.groupBounds, info.chartType);
            }

            return result;
        });

        return this._joinData(coordinateData);
    },

    /**
     * Find candidates.
     * @param {{bound: {left: number, top: number, right: number, bottom: number}}} data data
     * @param {number} layerX layerX
     * @param {number} layerY layerY
     * @returns {Array.<{sendData: object}>} candidates
     * @private
     */
    _findCandidates: function(data, layerX, layerY) {
        return tui.util.filter(data, function(datum) {
            var bound = datum && datum.bound,
                included = false,
                includedX, includedY;

            if (bound) {
                includedX = bound.left <= layerX && bound.right >= layerX;
                includedY = bound.top <= layerY && bound.bottom >= layerY;
                included = includedX && includedY;
            }

            return included;
        });
    },

    /**
     * Find tooltip data.
     * @param {number} groupIndex group index
     * @param {number} layerX mouse position x
     * @param {number} layerY mouse position y
     * @returns {object} tooltip data
     */
    findData: function(groupIndex, layerX, layerY) {
        var min = 10000,
            result = null,
            candidates;

        if (groupIndex > -1) {
            // layerX, layerY를 포함하는 data 추출
            candidates = this._findCandidates(this.data[groupIndex], layerX, layerY);

            // 추출된 data 중 top이 layerY와 가장 가까운 data 찾아내기
            tui.util.forEachArray(candidates, function(data) {
                var diff = Math.abs(layerY - data.sendData.bound.top);
                if (min > diff) {
                    min = diff;
                    result = data.sendData;
                }
            });
        }

        return result;
    }
});

module.exports = BoundsBaseCoordinateModel;
