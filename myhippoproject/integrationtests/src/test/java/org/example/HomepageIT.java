package org.example;

import org.junit.Assert;
import org.junit.Test;

public class HomepageIT extends WebDriverTestCase {

    @Test
    public void testThatHomePageHasATitle() throws Exception {
        getDriver().get(getBaseUrl() + Homepage.PATH);

        String title = getDriver().getTitle();

        Assert.assertEquals("myhippoproject Home Page", title);
    }
}
