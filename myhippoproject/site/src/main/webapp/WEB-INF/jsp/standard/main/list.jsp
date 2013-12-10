<%@ include file="/WEB-INF/jspf/htmlTags.jspf" %>
<%--@elvariable id="info" type="${package}.componentsinfo.ListInfo"--%>
<%--@elvariable id="result" type="org.hippoecm.hst.content.beans.query.HstQueryResult"--%>

<c:choose>
  <c:when test="${empty info}">
    <tag:pagenotfound/>
  </c:when>
  <c:otherwise>
    <div class="${fn:escapeXml(info.cssClass)}">
      <h2>${fn:escapeXml(info.title)}</h2>

      <c:forEach var="item" items="${result.hippoBeans}" varStatus="status">
        <hst:link var="link" hippobean="${item}"/>
        <article class="well well-large" style="background-color:${info.bgColor};">
          <hst:cmseditlink hippobean="${item}"/>
          <c:if test="${status.first and hst:isReadable(item, 'image.thumbnail')}">
            <hst:link var="img" hippobean="${item.image.thumbnail}"/>
            <figure style="float:left;margin:0 10px 0 0;">
              <img src="${img}" title="${fn:escapeXml(item.image.fileName)}"
                alt="${fn:escapeXml(item.image.fileName)}"/>
            </figure>
          </c:if>
          <h3><a href="${link}">${fn:escapeXml(item.title)}</a></h3>
          <c:if test="${hst:isReadable(item, 'date.time')}">
            <p class="badge badge-info">
              <fmt:formatDate value="${item.date.time}" type="both" dateStyle="medium" timeStyle="short"/>
            </p>
          </c:if>
          <p>${fn:escapeXml(item.summary)}</p>
        </article>
      </c:forEach>

    </div>
  </c:otherwise>
</c:choose>