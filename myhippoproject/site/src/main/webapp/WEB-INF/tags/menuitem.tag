<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>

<%@ attribute name="siteMenuItem" type="org.hippoecm.hst.core.sitemenu.HstSiteMenuItem" rtexprvalue="true"
  required="true" %>

<c:choose>
  <c:when test="${siteMenuItem.selected}">
    <li class="active">
      <a href="#">${fn:escapeXml(siteMenuItem.name)}</a>
      <c:if test="${siteMenuItem.expanded and not empty siteMenuItem.childMenuItems}">
        <ul>
          <c:forEach var="child" items="${siteMenuItem.childMenuItems}">
            <tag:menuitem siteMenuItem="${child}"/>
          </c:forEach>
        </ul>
      </c:if>
    </li>
  </c:when>
  <c:otherwise>
    <c:choose>
      <c:when test="${empty siteMenuItem.externalLink}">
        <hst:link var="link" link="${siteMenuItem.hstLink}"/>
      </c:when>
      <c:otherwise>
        <c:set var="link" value="${fn:escapeXml(siteMenuItem.externalLink)}"/>
      </c:otherwise>
    </c:choose>
    <li>
      <a href="${link}">${fn:escapeXml(siteMenuItem.name)}</a>
      <c:if test="${siteMenuItem.expanded and not empty siteMenuItem.childMenuItems}">
        <ul>
          <c:forEach var="child" items="${siteMenuItem.childMenuItems}">
            <tag:menuitem siteMenuItem="${child}"/>
          </c:forEach>
        </ul>
      </c:if>
    </li>
  </c:otherwise>
</c:choose>