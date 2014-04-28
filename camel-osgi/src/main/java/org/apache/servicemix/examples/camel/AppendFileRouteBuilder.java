/* 
 * AppendFileRouteBuilder.java
 *
 * 2014 SMT Software. UMK SEUP project.
 */
package org.apache.servicemix.examples.camel;

import org.apache.camel.builder.RouteBuilder;

/**
 * @author pkaczanowski
 * @version 28 kwi 2014
 */
public class AppendFileRouteBuilder extends RouteBuilder {

    @Override
    public void configure() throws Exception {

        from("timer:appendFileWithTime?period=2s&fixedRate=true")
                .
                //nie da sie uzyc date:property.CamelTimerFiredTime
                setHeader("fireTime", simple("${property.CamelTimerFiredTime}"))
                .
                transform(
                        simple("Timer ${property.CamelTimerName} fired at ${date:in.header.fireTime:yyyy-MM-dd HH:mm:ss} - current couter is ${property.CamelTimerCounter}\\r\\n"))
                .
                to("log:pl.com.smt.append.file").
                to("file:c:/temp/?fileName=execution-times.txt&fileExist=Append");

    }
}
