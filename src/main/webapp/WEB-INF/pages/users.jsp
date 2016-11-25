<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>

<html>
<head>
    <%@ page isELIgnored="false" %>
    <title>Users Page</title>

    <style type="text/css">
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }

        .tg td {
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px 2px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #fff;
            text-align:center
        }

        .tg th {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: bold;
            padding: 10px 2px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #f0f0f0;
        }

        .tg .tg-4eph {
            background-color: #f9f9f9
        }
    </style>

</head>

<a href="../../index.jsp">Start Page</a>

<br/>

<h3>User List</h3>

<body>
<div id="pagination">
    <c:if test="${!empty listUsers}">
        <c:url value="users" var="prev">
            <c:param name="page" value="${page-1}"/>
        </c:url>
        <c:if test="${page > 1}">
            <a href="<c:out value="${prev}" />" class="pn next">Prev</a>
        </c:if>

        <c:forEach begin="1" end="${lastPage}" step="1" varStatus="i">
            <c:choose>
                <c:when test="${page == i.index}">
                    <span>${i.index}</span>
                </c:when>
                <c:otherwise>
                    <c:url value="users" var="url">
                        <c:param name="page" value="${i.index}"/>
                    </c:url>
                    <a href='<c:out value="${url}" />'>${i.index}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:url value="users" var="next">
            <c:param name="page" value="${page + 1}"/>
        </c:url>
        <c:if test="${page + 1 <= lastPage}">
            <a href='<c:out value="${next}" />' class="pn next">Next</a>
        </c:if>
    </c:if>
</div>

<c:if test="${!empty listUsers}">
    <table class="tg">
        <tr>
            <th width="60">ID</th>
            <th width="120">Name</th>
            <th width="120">Age</th>
            <th width="120">Is Admin?</th>
            <th width="180">Created/Modified Date</th>
            <th width="60">Edit</th>
            <th width="60">Delete</th>
        </tr>
        <c:forEach items="${listUsers}" var="user">
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.age}</td>
                <td>${user.isAdmin}</td>
                <td ><fmt:formatDate value="${user.createdDate}"  type="both"  pattern="MM/dd/yyyy"/></td>
                <td><a href="<c:url value='/edit/${user.id}#anchor'/>">Edit</a></td>
                <td><a href="<c:url value='/remove/${user.id}'/>">Delete</a></td>
            </tr>
        </c:forEach>
    </table>
</c:if>


<h3>Add/Edit User</h3>

<c:url var="addAction" value="/users/add/"/>

<form:form action="${addAction}" commandName="user">
    <table id="anchor" class="tg">
        <c:if test="${!empty user.createdDate}">
            <tr>
                <td>
                    <form:label path="id">
                        <spring:message text="ID"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="id" readonly="true" size="8" disabled="true"/>
                    <form:hidden path="id"/>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="name">
                    <spring:message text="Name"/>
                </form:label>
            </td>
            <td>
                <form:input maxlength="25" path="name" type="text"/>
            </td>
        </tr>

        <tr>
            <td>
                <form:label path="age">
                    <spring:message text="Age"/>
                </form:label>
            </td>
            <td>
                <form:input maxlength="2" path="age" type="number"
                            onchange="if ((this.value <= 0) || (this.value > 99))  {this.value = 30 ;
                            alert('Type value between 1 and 99')}"/>
            </td>
        </tr>

        <tr>
            <td>
                <form:label path="isAdmin">
                    <spring:message text="Is Admin?"/>
                </form:label>
            </td>
            <td>
                <form:radiobutton name="isAdmin" path="isAdmin" value="No" label="No" textcolor ='red' />
                <form:radiobutton name="isAdmin" path="isAdmin" value="Yes" label="Yes" />
            </td>
        </tr>

        <tr>
            <td colspan="2">
                <c:if test="${user.id != 0}">
                    <input type="submit"
                           value="<spring:message text="Edit User"/>"/>
                </c:if>
                <c:if test="${user.id == 0}">
                    <input type="submit"
                           value="<spring:message text="Add User"/>"/>
                </c:if>
            </td>
        </tr>

    </table>
</form:form>



<c:url var="addSearchById" value="/userdataid/${user.id}"/>

<form:form action="${addSearchById}" modelAttribute="user" method="GET">
<c:if test="${!empty listUsers}">
    <h3>Search User by ID</h3>
    <table class="tg">
        <tr>
            <td>
                <form:label path="id">
                    <spring:message text="ID"/>
                </form:label>
            </td>
            <td>
                <form:input path="id" maxlength="8" type="number"
                            onchange="if (this.value <= 0) {this.value = 1 ; alert('Wrong ID value')}"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="<spring:message text="Search User"/>"/>
            </td>
        </tr>
    </table>
</c:if>
</form:form>

<c:url var="addSearchByName" value="/userdataname/${user.name}"/>

<form:form action="${addSearchByName}" modelAttribute="user" method="GET">
    <c:if test="${!empty listUsers}">
        <h3>Search User by Name</h3>
        <table class="tg">
            <tr>
                <td>
                    <form:label path="name">
                        <spring:message text="Name"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="name" maxlength="25"
                                type="text" name="name" style="color: #777;"
                                value="User name" onfocus="if (this.value == 'User name')
                             {this.value = ''; this.style.color = '#000';}" onblur="if (this.value == '')
                             {this.value = 'User name'; this.style.color = '#777';}"/>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="<spring:message text="Search User"/>"/>
                </td>
            </tr>
        </table>
    </c:if>
</form:form>

</body>
</html>