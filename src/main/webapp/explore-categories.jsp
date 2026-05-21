<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="mb-12">
    <h1 class="text-4xl font-[900] text-slate-900 tracking-tight mb-2">Explore Categories</h1>
    <p class="text-slate-500 font-medium italic">Select a category workspace to browse all snippets.</p>
</header>

<div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
    <c:forEach var="cat" items="${categoryList}">
        <a href="user-home?view=category&catId=${cat.id}" class="cheat-card bg-white p-8 rounded-[2rem] border border-slate-100 shadow-sm flex items-center justify-between group">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 rounded-2xl bg-indigo-50 text-indigo-600 flex items-center justify-center font-bold text-lg group-hover:bg-indigo-600 group-hover:text-white transition-all">
                    <i class="fa-solid fa-layer-group text-sm"></i>
                </div>
                <div>
                    <h3 class="font-extrabold text-slate-800 text-lg group-hover:text-indigo-600 transition-colors">${cat.name}</h3>
                    <p class="text-xs text-slate-400 font-medium">Click to view documents</p>
                </div>
            </div>
            <i class="fa-solid fa-arrow-right text-slate-300 group-hover:translate-x-1 group-hover:text-indigo-600 transition-all"></i>
        </a>
    </c:forEach>
</div>