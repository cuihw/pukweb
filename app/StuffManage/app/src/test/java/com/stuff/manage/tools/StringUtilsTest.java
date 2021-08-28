package com.stuff.manage.tools;

import junit.framework.TestCase;
import junit.framework.TestResult;

import org.junit.Test;

public class StringUtilsTest extends TestCase {


    @Test
    public void testIsPureDigital() {
        boolean ret = StringUtils.isPureDigital("-200");
        assertEquals(false,ret);
         ret = StringUtils.isPureDigital("100.25");
        assertEquals(false,ret);
        ret = StringUtils.isPureDigital("25");
        assertEquals(true,ret);
        ret = StringUtils.isPureDigital("1");
        assertEquals(true,ret);
        ret = StringUtils.isPureDigital("12.5");
        assertEquals(false,ret);
    }
}