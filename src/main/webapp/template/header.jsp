<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-green: #2d5a27; /* Approximating the oklch primary */
            --bg-light: #f8faf7;
        }
        body { background-color: var(--bg-light); font-family: sans-serif; }
        .hero-section {
            background: linear-gradient(135deg, var(--primary-green) 0%, #3e7a36 100%);
            color: white;
            padding: 100px 0;
        }
        .btn-primary { background-color: var(--primary-green); border: none; }
        .btn-outline-light:hover { color: var(--primary-green); }
        .product-card { transition: transform 0.2s; border: none; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .product-card:hover { transform: translateY(-5px); }
        .footer { background-color: #1a1a1a; color: white; padding: 40px 0; }
        .feature-icon {
            width: 64px; height: 64px;
            background-color: var(--primary-green);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin: 0 auto 20px;
        }
    </style>
</head>