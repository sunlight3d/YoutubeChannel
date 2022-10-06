<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <h2>Insert new product</h2>
    <form:form method="POST"
        action="/products/insertProduct"  
        modelAttribute="product">
        <form:input type="text"             
            placeholder="Enter product's name"
            value="${product.getProductName()}" 
            path="productName"
        /><br>    
        <form:errors path="productName" cssClass="error"/> <br>           
        <form:input type="number"     
            placeholder="Enter product's price"
            value="${product.getPrice()}" 
            path="price"
        /><br/>  
        <form:errors path="price" cssClass="error" /> <br>
        <form:input type="text"             
            placeholder="Enter description"
            value="${product.getDescription()}"
            path="description"
        /><br/>     
        <form:errors path="description" cssClass="error"/> <br>       
        <form:select path="categoryID">
            <c:forEach var="category" items="${categories}">
                <form:option value="${category.getCategoryID()}">
                    ${category.getCategoryName()}
                </form:option>
            </c:forEach>                        
        </form:select>
        <p class="error">${error}</p>    
        <input type="submit" value="Insert" />
    </form:form>
    
</body>
</html>