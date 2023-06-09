package egovframework.diam.cmm.selenium;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import egovframework.diam.cmm.model.Dm_crawl_vo;
import egovframework.diam.cmm.util.CommonUtil;

public class CrawlingUtil {

	public Dm_crawl_vo crawlYoutube() throws Exception {
		CommonUtil commonUtil = new CommonUtil();
		
		String mode = System.getProperty("globals.properties.mode");
		String driverPath = "";
		if(mode.equals("dev")) {
			driverPath = "D:\\Util\\chromedriver_win32\\chromedriver.exe";
		} else {
			driverPath = "/usr/local/bin/chromedriver";
		}

		System.setProperty("webdriver.chrome.driver", driverPath);
		ChromeOptions options = new ChromeOptions();
		// GUI 없이 실행
		options.addArguments("headless"); 
		// "no sandbox" 옵션 추가
        options.addArguments("--no-sandbox");
        // "disable-gpu" 옵션 추가
        options.addArguments("--disable-gpu");

		WebDriver driver = new ChromeDriver(options);
		WebDriverWait wait = new WebDriverWait(driver, 10);
		
		System.out.println("connection chrome driver.......");

		driver.get("https://www.youtube.com/@ecogj/videos");
		driver.manage().timeouts().implicitlyWait(2, TimeUnit.SECONDS);
		
		System.out.println("get ecog youtube page........");

		WebElement eleWrap = wait.until(ExpectedConditions
				.presenceOfElementLocated(By.xpath("//div[@id='dismissible'][1]//a[@id='thumbnail']")));
		eleWrap.click();
		
		System.out.println("get newest video.............");

		Thread.sleep(5000);

		System.out.println("set this url................");
		String currentUrl = driver.getCurrentUrl();
		

		System.out.println("chromedriver quit.....................");
		driver.quit();

		if (!commonUtil.isNullOrEmpty(currentUrl)) {
			return Dm_crawl_vo.builder().dm_type("2").dm_href(currentUrl).build();
		} else {
			return null;
		}

	}

	public List<Dm_crawl_vo> crawlInstagram() throws Exception {
		CommonUtil commonUtil = new CommonUtil();
		
		String mode = System.getProperty("globals.properties.mode");
		String driverPath = "";
		if(mode.equals("dev")) {
			driverPath = "D:\\Util\\chromedriver_win32\\chromedriver.exe";
		} else {
			driverPath = "/usr/local/bin/chromedriver";
		}
		
		System.setProperty("webdriver.chrome.driver", driverPath);

		ChromeOptions options = new ChromeOptions();
		// GUI 없이 실행
		options.addArguments("headless"); 
		// "no sandbox" 옵션 추가
        options.addArguments("--no-sandbox");
        // "disable-gpu" 옵션 추가
        options.addArguments("--disable-gpu");
        
		WebDriver driver = new ChromeDriver(options);
		System.out.println("connection chrome driver.......");
		
		WebDriverWait wait = new WebDriverWait(driver, 10);

		driver.get("https://www.instagram.com/accounts/login/");
		driver.manage().timeouts().implicitlyWait(2, TimeUnit.SECONDS);
		System.out.println("get instagram login page......");
		
		// 인스타그램 로그인 페이지에서 로그인하는 코드
		// 아이디와 비밀번호 입력
		WebElement username = wait.until(ExpectedConditions.presenceOfElementLocated(By.name("username")));
		username.sendKeys("ecogwangju_official");
		System.out.println("set username................");
		
		WebElement password = driver.findElement(By.name("password"));
		password.sendKeys("ecog5274!!");
		System.out.println("set password................");
		// 로그인 버튼 클릭
		WebElement loginButton = driver.findElement(By.xpath("//button[@type='submit']"));
		loginButton.click();
		System.out.println("signing ....................");
		
		Thread.sleep(5000);

		// 로그인 후, 프로필 페이지로 이동
		String profileUrl = "https://www.instagram.com/ecogwangju_official/";
		driver.get(profileUrl);
		System.out.println("get feed list.................");

		WebElement mainEle = wait.until(ExpectedConditions.presenceOfElementLocated(By.xpath("//main[@role='main']")));
		List<WebElement> feed = mainEle
				.findElements(By.xpath("//main[@role='main']//*[self::article]//*[@role='link']"));
		System.out.println("find post.......................");
		List<Dm_crawl_vo> list = new ArrayList<>();

		for (WebElement post : feed) {
			// 각 포스트의 href 속성
			String href = post.getAttribute("href");
			WebElement img = post.findElement(By.tagName("img"));
			String src = img.getAttribute("src");
			
			if (!commonUtil.isNullOrEmpty(href) && !commonUtil.isNullOrEmpty(src)) {
				list.add(Dm_crawl_vo.builder().dm_type("1").dm_href(href).dm_src(src).build());
			}
		}
		System.out.println("chromedriver quit.....................");
		driver.quit();

		if (list.size() > 0) {
			Collections.reverse(list);
			
			list.forEach(item -> {
				System.out.println(item.toString());
			});
		}

		return list;
	}

}
