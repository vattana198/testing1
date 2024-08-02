<%--
/**
 * SPDX-FileCopyrightText: (c) 2000 Liferay, Inc. https://liferay.com
 * SPDX-License-Identifier: LGPL-2.1-or-later OR LicenseRef-Liferay-DXP-EULA-2.0.0-2023-06
 */
--%>

<%@ include file="/html/taglib/aui/nav_item/init.jsp" %>

<%
Object bodyContent = request.getAttribute("aui:nav-item:bodyContent");

String bodyContentString = StringPool.BLANK;

if (bodyContent != null) {
	bodyContentString = bodyContent.toString();
}

if (Validator.isNull(title)) {
	title = HtmlUtil.stripHtml(LanguageUtil.get(resourceBundle, label));
}
%>

<c:if test="<%= !dropdown || Validator.isNotNull(bodyContentString.trim()) %>">
	<li class="<%= cssClass %><%= !dropdown ? " nav-item " : "" %><%= state %>" id="<%= id %>" role="presentation" <%= AUIUtil.buildData(data) %> <%= InlineUtil.buildDynamicAttributes(dynamicAttributes) %>>
		<c:if test="<%= Validator.isNotNull(iconCssClass) || Validator.isNotNull(label) %>">
			<c:if test="<%= Validator.isNotNull(href) %>">
				<a <%= Validator.isNotNull(ariaLabel) ? "aria-label=\"" + ariaLabel + "\"" : StringPool.BLANK %> class="<%= anchorCssClass %><%= !dropdown ? " nav-link " : "" %><%= selected ? " active " : StringPool.SPACE %>" <%= AUIUtil.buildData(anchorData) %> href="<%= HtmlUtil.escapeAttribute(href) %>" id="<%= anchorId %>" role="<%= Validator.isNull(ariaRole) ? "menuitem" : ariaRole %>" <%= Validator.isNotNull(target) ? "target=\"" + target + "\"" : StringPool.BLANK %> title="<liferay-ui:message key="<%= title %>" />">
					<span class="c-inner" tabindex="-1">

				<c:if test="<%= useDialog %>">
					<aui:script>
						Liferay.delegateClick('<%= anchorId %>', Liferay.Util.openInDialog);
					</aui:script>
				</c:if>
			</c:if>
					<c:choose>
						<c:when test="<%= Validator.isNotNull(iconCssClass) %>">
							<i class="nav-item-icon <%= iconCssClass %>"></i>
						</c:when>
						<c:when test="<%= Validator.isNotNull(iconSrc) %>">
							<i class="nav-item-icon"><img src="<%= iconSrc %>" /></i>
						</c:when>
					</c:choose>

					<span class="navbar-text-truncate">
						<liferay-ui:message key="<%= label %>" localizeKey="<%= localizeLabel %>" />
					</span>

					<c:if test="<%= dropdown %>">
						<liferay-ui:icon
							icon="caret-bottom"
							markupView="lexicon"
						/>
					</c:if>
			<c:if test="<%= Validator.isNotNull(href) %>">
				<c:if test="<%= !useDialog && AUIUtil.isOpensNewWindow(target) %>">
					<span class="opens-new-window-accessible"><liferay-ui:message key="opens-new-window" /></span>
				</c:if>

					</span>
				</a>
			</c:if>
		</c:if>

		<c:if test="<%= dropdown %>">
			<aui:script use="aui-base,event-move,event-outside,liferay-menu-toggle,liferay-store">
				new Liferay.MenuToggle(
					{
						content: '#<%= id %>',
						maxDisplayItems: <%= PropsValues.MENU_MAX_DISPLAY_ITEMS %>,
						'strings.placeholder': '<liferay-ui:message key="search" />',
						toggle: <%= toggle %>,
						toggleTouch: <%= toggleTouch %>,
						trigger: '#<%= id %> a'
					}
				);
			</aui:script>

			<c:if test="<%= wrapDropDownMenu %>">
				<ul class="dropdown-menu">
			</c:if>
		</c:if>

		<c:if test="<%= Validator.isNotNull(bodyContentString) %>">
			<%= bodyContentString %>
		</c:if>

		<c:if test="<%= dropdown && wrapDropDownMenu %>">
			</ul>
		</c:if>
	</li>
</c:if>