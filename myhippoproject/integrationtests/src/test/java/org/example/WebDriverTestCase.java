package org.example;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.logging.Level;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.logging.LogType;
import org.openqa.selenium.logging.LoggingPreferences;
import org.openqa.selenium.phantomjs.PhantomJSDriver;
import org.openqa.selenium.phantomjs.PhantomJSDriverService;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class WebDriverTestCase {

    private WebDriver driver;

    private static final Logger logger = LoggerFactory.getLogger(WebDriverTestCase.class);

    private static String baseUrl;
    private static PhantomJSDriverService service;

    protected static String getBaseUrl() {
        return baseUrl;
    }

    protected WebDriver getDriver() {
        return driver;
    }

    @BeforeClass
    public static void globalSetup() throws Exception {
        String containerIpFileName = System.getProperty("container_ip_file");

        Path path = Paths.get(containerIpFileName);

        List<String> lines = Files.readAllLines(path, Charset.forName("utf-8"));
        baseUrl = "http://" + lines.get(0) + ":8080/site";

        System.out.println("Base url = " + baseUrl);

        if (containerIpFileName == null) {
            throw new IllegalStateException("No container_ip_file specified, can't resolve base URL");
        }

        service = PhantomJSDriverService.createDefaultService();
        service.start();
    }

    /**
     * Teardown any services used in running the tests in this class.
     */
    @AfterClass
    public static void globalTearDown() {
        if (service != null) {
            service.stop();
            service = null;
        }
    }

    @Before
    public void setUp() throws Exception {
        DesiredCapabilities capabilities = DesiredCapabilities.phantomjs();
        capabilities.setJavascriptEnabled(true);
        capabilities.setCapability(CapabilityType.TAKES_SCREENSHOT, Boolean.TRUE);

        LoggingPreferences prefs = new LoggingPreferences();
        prefs.enable(LogType.BROWSER, Level.WARNING);
        prefs.enable(LogType.DRIVER, Level.INFO);
        capabilities.setCapability(CapabilityType.LOGGING_PREFS, prefs);

        driver = new PhantomJSDriver(service, capabilities);

        WebDriver.Options options = driver.manage();
        WebDriver.Window window = options.window();

        // Make sure all elements are visible.
        window.setSize(new Dimension(1920, 1080));
    }

    /**
     * Write out the browser logs after a test.
     *
     */
    @After
    public void tearDown() {
/* Commented out, because ubuntu doesn't have the right phantomjs version..

        Logs logs = driver.manage().logs();

        LogEntries entries = logs.get(LogType.BROWSER);
        for (LogEntry entry : entries.getAll()) {
            logger.info(entry.toString());
        }
        driver.quit();
*/
    }
}
