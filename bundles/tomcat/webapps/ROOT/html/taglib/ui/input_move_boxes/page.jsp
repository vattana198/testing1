<%--
/**
 * SPDX-FileCopyrightText: (c) 2000 Liferay, Inc. https://liferay.com
 * SPDX-License-Identifier: LGPL-2.1-or-later OR LicenseRef-Liferay-DXP-EULA-2.0.0-2023-06
 */
--%>

<%@ include file="/html/taglib/init.jsp" %>

<%
String randomNamespace = PortalUtil.generateRandomKey(request, "taglib_ui_input_move_boxes_page") + StringPool.UNDERLINE;

String cssClass = GetterUtil.getString((String)request.getAttribute("liferay-ui:input-move-boxes:cssClass"));

String leftTitle = LanguageUtil.get(resourceBundle, (String)request.getAttribute("liferay-ui:input-move-boxes:leftTitle"));
String rightTitle = LanguageUtil.get(resourceBundle, (String)request.getAttribute("liferay-ui:input-move-boxes:rightTitle"));

Integer leftBoxMaxItems = (Integer)request.getAttribute("liferay-ui:input-move-boxes:leftBoxMaxItems");
Integer rightBoxMaxItems = (Integer)request.getAttribute("liferay-ui:input-move-boxes:rightBoxMaxItems");

String leftBoxName = (String)request.getAttribute("liferay-ui:input-move-boxes:leftBoxName");
String rightBoxName = (String)request.getAttribute("liferay-ui:input-move-boxes:rightBoxName");

String leftOnChange = (String)request.getAttribute("liferay-ui:input-move-boxes:leftOnChange");
String rightOnChange = (String)request.getAttribute("liferay-ui:input-move-boxes:rightOnChange");

boolean leftReorder = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-move-boxes:leftReorder"));
boolean rightReorder = GetterUtil.getBoolean((String)request.getAttribute("liferay-ui:input-move-boxes:rightReorder"));

List leftList = (List)request.getAttribute("liferay-ui:input-move-boxes:leftList");
List rightList = (List)request.getAttribute("liferay-ui:input-move-boxes:rightList");

Map<String, Object> data = new HashMap<String, Object>();
%>

<div class="taglib-move-boxes <%= cssClass %> <%= leftReorder ? "left-reorder" : StringPool.BLANK %> <%= rightReorder ? "right-reorder" : StringPool.BLANK %>" id="<%= randomNamespace %>input-move-boxes">
	<div class="row selector-container">
		<div class="col-md-4 left-selector-column">
			<aui:select cssClass="choice-selector left-selector" label="<%= leftTitle %>" multiple="<%= true %>" name="<%= leftBoxName %>" onChange="<%= Validator.isNotNull(leftOnChange) ? leftOnChange : StringPool.BLANK %>" size="10">

				<%
				data.put("selected", true);

				for (int i = 0; i < leftList.size(); i++) {
					KeyValuePair kvp = (KeyValuePair)leftList.get(i);
				%>

					<aui:option data="<%= data %>" label="<%= kvp.getValue() %>" value="<%= kvp.getKey() %>" />

				<%
				}
				%>

			</aui:select>
		</div>

		<div class="col-md-1 move-arrow-buttons"></div>

		<div class="col-md-4 right-selector-column">
			<aui:select cssClass="choice-selector right-selector" label="<%= rightTitle %>" multiple="<%= true %>" name="<%= rightBoxName %>" onChange="<%= Validator.isNotNull(rightOnChange) ? rightOnChange : StringPool.BLANK %>" size="10">

				<%
				data.put("selected", false);

				for (int i = 0; i < rightList.size(); i++) {
					KeyValuePair kvp = (KeyValuePair)rightList.get(i);
				%>

					<aui:option data="<%= data %>" label="<%= kvp.getValue() %>" value="<%= kvp.getKey() %>" />

				<%
				}
				%>

			</aui:select>
		</div>
	</div>
</div>

<aui:script use="liferay-input-move-boxes">
	new Liferay.InputMoveBoxes(
		{
			contentBox: '#<%= randomNamespace %>input-move-boxes',

			<c:if test="<%= leftBoxMaxItems != null %>">
				leftBoxMaxItems: <%= leftBoxMaxItems %>,
			</c:if>

			<c:if test="<%= rightBoxMaxItems != null %>">
				rightBoxMaxItems: <%= rightBoxMaxItems %>,
			</c:if>

			strings: {
				LEFT_MOVE_DOWN: '<%= UnicodeLanguageUtil.format(request, "move-selected-item-in-x-one-position-down", leftTitle, false) %>',
				LEFT_MOVE_UP: '<%= UnicodeLanguageUtil.format(request, "move-selected-item-in-x-one-position-up", leftTitle, false) %>',
				MOVE_LEFT: '<%= UnicodeLanguageUtil.format(request, "move-selected-items-from-x-to-x", new Object[] {rightTitle, leftTitle}, false) %>',
				MOVE_RIGHT: '<%= UnicodeLanguageUtil.format(request, "move-selected-items-from-x-to-x", new Object[] {leftTitle, rightTitle}, false) %>',
				RIGHT_MOVE_DOWN: '<%= UnicodeLanguageUtil.format(request, "move-selected-item-in-x-one-position-down", rightTitle, false) %>',
				RIGHT_MOVE_UP: '<%= UnicodeLanguageUtil.format(request, "move-selected-item-in-x-one-position-up", rightTitle, false) %>'
			}
		}
	).render();
</aui:script>