<%@ include file="/WEB-INF/jspf/taglibs.jspf" %>
<%@ attribute name="pages" required="true" type="java.util.List" rtexprvalue="true" %>
<%@ attribute name="page" required="true" type="java.lang.Integer" rtexprvalue="true" %>
<c:if test="${not empty pages}">
  <div class="pagination">
    <ul>
      <c:forEach var="p" items="${pages}">
        <c:set var="active" value=""/>
        <c:choose>
          <c:when test="${page == p}">
            <li class="active"><a href="#">${page}</a></li>
          </c:when>
          <c:otherwise>
            <hst:renderURL var="pagelink">
              <hst:param name="page" value="${p}"/>
            </hst:renderURL>
            <li><a href="${pagelink}" title="${p}">${p}</a></li>
          </c:otherwise>
        </c:choose>
      </c:forEach>
    </ul>
  </div>
</c:if>