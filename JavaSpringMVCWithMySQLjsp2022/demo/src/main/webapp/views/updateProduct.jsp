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
    <p>Do you really want to assign product: 
        <strong>${product.getProductName()}</strong> to other category ?
    </p>
    <form:form method="POST"
        action="/products/updateProduct/${product.getProductID()}"  
        modelAttribute="product">
        <form:input type="text" 
            value="${product.getProductName()}" 
            placeholder="Enter product's name"
            path="productName"
        /><br>    
        <form:errors path="productName" cssClass="error"/> <br>           
        <form:input type="number" 
            value="${product.getPrice()}" 
            placeholder="Enter product's price"
            path="price"
        /><br/>  
        <form:errors path="price" cssClass="error" /> <br>
        <form:input type="text" 
            value="${product.getDescription()}" 
            placeholder="Enter description"
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
        <input type="submit" value="Update" />        
    </form:form>        
    <form:form 
        method="POST"
        action="/products/deleteProduct/${product.getProductID()}"
        onsubmit="return confirm('Are you sure you want to delete this Product?') ? true: false"
        >
        <input type="submit" value="Delete"/>
    </form:form>    
</body>
</html>