<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="world.thismagical.util.JsonApi" %>
<%@ page import="world.thismagical.to.SettingsTO" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  SessionFactory sessionFactory = JsonApi.getSessionFactory(application);
  SettingsTO settingsTO = JsonApi.getNoAuthSettingsCached(application);
  ObjectMapper objectMapper = new ObjectMapper();
%>

<html>
<!--
                                        `.------:::--...``.`
                                    `-:+hmmoo+++dNNmo-.``/dh+...
                                   .+/+mNmyo++/+hmmdo-.``.odmo -/`
                                 `-//+ooooo++///////:---..``.````-``
                           `````.----:::/::::::::::::--------.....--..`````
           ```````````...............---:::-----::::---..------------------........```````
        `:/+ooooooosssssssyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyysssssssssssssssssssssssssssoo+/:`
          ``..-:/++ossyhhddddddddmmmmmarea51mbobmlazarmmmmmmmddddddddddddddhhyysoo+//:-..``
                      ```..--:/+oyhddddmmmmmmmmmmmmmmmmmmmmmmmddddys+/::-..````
                                 ``.:oshddmmmmmNNNNNNNNNNNmmmhs+:.`
                                       `.-/+oossssyysssoo+/-.`

-->
  <head>

    <meta name="settingsTOCache" content="<% out.print(JsonApi.toBase64(objectMapper.writeValueAsString(settingsTO))); %>">

    <jsp:include page="head-standard.jsp"/>
    <jsp:include page="head-client.jsp"/>

    <title><% out.print(settingsTO.websiteName); %></title>

    <script src="cda/homepage.js"></script>
    <script src="cda/header.js"></script>

  </head>
  <body class="cda">

  <div data-role="header-main" class="width-100-pc"></div>
  <div data-role="content-main" class="width-100-pc"></div>

  <script type="text/javascript">
    $('[data-role="header-main"]').header();
    $('[data-role="content-main"]').homepage();
  </script>

  </body>
</html>
