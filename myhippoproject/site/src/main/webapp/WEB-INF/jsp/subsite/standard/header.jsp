<%@ include file="/WEB-INF/jspf/htmlTags.jspf" %>
<%--@elvariable id="headerName" type="java.lang.String"--%>
<div class="container-fluid">
  <div class="row-fluid">
    <div class="span2"></div>
    <div class="span8">
      <div class="navbar">
        <div class="navbar-inner">
          <h1 class="container">
            <hst:link var="homeLink" path="/"/>
            <h1><a class="brand" href="${homeLink}">${fn:escapeXml(headerName)}</a></h1>
          </h1>
        </div>
      </div>
    </div>
    <div class="span2"></div>
  </div>
</div>