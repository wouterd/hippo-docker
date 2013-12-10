<%@ include file="/WEB-INF/jspf/htmlTags.jspf" %>
<%--@elvariable id="headerName" type="java.lang.String"--%>
<div class="container-fluid">
  <div class="row-fluid">
    <div class="span2"></div>
    <div class="span8">
      <div class="navbar">
        <div class="navbar-inner">
          <div class="container">
            <hst:link var="homeLink" path="/"/>
            <h1><a class="brand" href="${homeLink}">${fn:escapeXml(headerName)}</a></h1>
            <div class="nav-collapse">
              <ul class="nav pull-right">
                <li>
                  <fmt:message var="submitText" key="search.submit.text"/>
                  <hst:link var="link" path="/search"/>

                  <form class="navbar-search form-search" action="${link}" method="get">
                    <p>
                      <input type="text" name="query" class="search-query input-xlarge" placeholder="${submitText}" required="required"/>
                      <button class="btn btn-primary inline" type="submit" value="${submitText}">${submitText}</button>
                    </p>
                  </form>
                </li>
              </ul>

            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="span2"></div>
  </div>
</div>