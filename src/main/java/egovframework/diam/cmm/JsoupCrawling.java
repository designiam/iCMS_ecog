package egovframework.diam.cmm;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import lombok.extern.log4j.Log4j2;

@Log4j2
public class JsoupCrawling {

	private static final String BASE_URL = "https://www.instagram.com/";
	private static final String USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36";
	private static final int MAX_POSTS = 12;

	public void main() throws IOException {
		String username = "gwangju_official";

		// 로그인 정보 가져오기
		String loginUrl = BASE_URL + "accounts/login/";
		URL url = new URL(loginUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("User-Agent", USER_AGENT);
		conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		conn.setRequestProperty("Connection", "keep-alive");
		conn.setDoOutput(true);

		// Instagram에서 로그인 쿠키 정보를 가져오기 위해 빈 POST 요청 보내기
		conn.getOutputStream().write("".getBytes());

		// 쿠키 정보 저장하기
		String cookie = conn.getHeaderField("Set-Cookie");
		// 포스트 링크 가져오기
		String urlStr = BASE_URL + username + "/";
		Document doc = Jsoup.connect(urlStr).header("Cookie", cookie).get();
		
		Elements postLinks = doc.select("a[href^=/p/]");

		// 각 포스트에서 이미지 링크와 캡션 가져오기
		int count = 0;
		for (Element postLink : postLinks) {
			// 최대 포스트 개수에 도달하면 종료
			if (count >= MAX_POSTS) {
				break;
			}
			// 포스트 페이지에서 데이터 가져오기
			String postUrl = BASE_URL + postLink.attr("href");
			Document postDoc = Jsoup.connect(postUrl).header("Cookie", cookie).get();
			Element image = postDoc.select("img[alt]").first();
			Element caption = postDoc.select(".eo2As .EtaWk .ltpMr span").first();

			// 이미지 링크와 캡션 출력하기
			if (image != null && caption != null) {
				System.out.println(image.attr("src"));
				System.out.println(caption.text());
				System.out.println();
				count++;
			}
		}
	}
}
