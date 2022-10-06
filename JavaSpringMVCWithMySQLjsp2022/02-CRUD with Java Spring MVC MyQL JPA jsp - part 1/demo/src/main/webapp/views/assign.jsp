<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <p>Do you really want to assign product: 
        <strong>${product.getProductName()}

        </strong> to other category ?
    </p>
    <form:form method="POST"
        action="/products/updateProduct/${product.getProductID()}"  
        modelAttribute="product">
        <form:select path="categoryID">
            <c:forEach var="category" items="${categories}">
                <form:option value="${category.getCategoryID()}">
                    ${category.getCategoryName()}
                </form:option>
            </c:forEach>                        
        </form:select>
        <input type="submit" value="Update">
    </form:form>
    

</body>
</html>