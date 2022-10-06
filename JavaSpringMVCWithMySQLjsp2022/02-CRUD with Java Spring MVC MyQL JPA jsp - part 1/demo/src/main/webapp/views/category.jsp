<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category list</title>
    <style>
        table,
        th,
        td {
            border: 1px solid black;
        }
    </style>
</head>
<body>
    <h1>Category list</h1>
    <!-- <h1>Name = ${name}, age = ${age}</h1> -->
    <!-- Display categories here, inside a Table -->
    <!--for better UI, let's use Bootstrap-->
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Actions</th>
          </tr>
          <c:forEach var="category" items="${categories}">
              <tr>
                  <td>${category.getCategoryID()}</td>
                  <td>${category.getCategoryName()}</td>
                  <td>${category.getDescription()}</td>
                  <td>
                    <a href="products/getProductsByCategoryID/${category.getCategoryID()}">
                      Show Products
                    </a>
                </td>
              </tr>
          </c:forEach>
    </table>
</body>
</html>
