<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- Security Check: Admin မဟုတ်ရင် ပြန်မောင်းထုတ်မယ် --%>
<c:if test="${empty userObj || userObj.role != 'ADMIN'}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Categories | CheatSheet</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; background: #f8fafc; }
        .sidebar-link:hover, .sidebar-link.active {
            background: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            color: #4f46e5;
        }
    </style>
</head>
<body class="flex min-h-screen">

    <aside class="w-72 bg-slate-50 border-r border-slate-200 p-6 flex flex-col fixed h-full">
        <div class="mb-12 px-2">
            <h1 class="text-2xl font-black bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">CheatSheet.</h1>
            <p class="text-[10px] font-bold text-slate-400 uppercase tracking-[2px] mt-1">Admin Central</p>
        </div>

        <nav class="space-y-2 flex-1">
            <a href="admin-dash" class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-2xl text-slate-500 text-sm font-bold transition-all">
                <i class="fa-solid fa-chart-pie text-lg"></i> Overview
            </a>
            <a href="manage-cheats" class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-2xl text-slate-500 text-sm font-bold transition-all">
                <i class="fa-solid fa-code-pull-request text-lg"></i> Manage Cheats
            </a>
            <a href="manage-categories" class="sidebar-link active flex items-center gap-3 px-4 py-3 rounded-2xl text-sm font-bold transition-all">
                <i class="fa-solid fa-tags text-lg"></i> Categories
            </a>
            <a href="manage-users" class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-2xl text-slate-500 text-sm font-bold transition-all">
                <i class="fa-solid fa-users-gear text-lg"></i> User Control
            </a>
        </nav>

        <div class="mt-auto p-4 bg-indigo-50 rounded-[2rem] border border-indigo-100">
            <div class="flex items-center gap-3 mb-3">
                <div class="w-10 h-10 rounded-full bg-indigo-600 flex items-center justify-center text-white text-xs font-bold">AD</div>
                <div>
                    <p class="text-xs font-bold text-slate-900">${userObj.username}</p>
                    <p class="text-[10px] text-indigo-500 font-bold uppercase">Super Admin</p>
                </div>
            </div>
            <a href="logout" class="block text-center bg-white text-red-500 text-xs font-bold py-2 rounded-xl border border-red-50 hover:bg-red-50 transition-colors">Logout</a>
        </div>
    </aside>

    <main class="ml-72 flex-1 p-10">
        
        <header class="flex justify-between items-center mb-10">
            <div>
                <h2 class="text-3xl font-extrabold text-slate-900">Category Workspace</h2>
                <p class="text-slate-500 text-sm">Create, organize and refine categories for organization.</p>
            </div>
            <div class="flex gap-4">
                <a href="admin-dash" class="bg-white px-4 py-2.5 rounded-xl border border-slate-200 shadow-sm hover:bg-slate-50 text-slate-700 text-xs font-bold transition flex items-center gap-2">
                    <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </header>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            
            <div class="bg-white p-6 rounded-[2rem] border border-slate-100 shadow-xl h-fit">
                <h3 class="text-sm font-black text-slate-800 uppercase tracking-wider mb-5 flex items-center gap-2">
                    <c:choose>
                        <c:when test="${not empty editCategory}">
                            <div class="w-7 h-7 rounded-lg bg-amber-50 text-amber-500 flex items-center justify-center text-xs"><i class="fa-solid fa-pen-to-square"></i></div> Edit Category
                        </c:when>
                        <c:otherwise>
                            <div class="w-7 h-7 rounded-lg bg-indigo-50 text-indigo-600 flex items-center justify-center text-xs"><i class="fa-solid fa-plus"></i></div> Add New Category
                        </c:otherwise>
                    </c:choose>
                </h3>
                
                <form action="manage-categories" method="POST" class="space-y-4">
                    <input type="hidden" name="categoryId" value="${editCategory.id}">
                    
                    <div>
                        <label class="block text-[10px] font-black uppercase tracking-wider text-slate-400 mb-2">Category Name</label>
                        <input type="text" name="categoryName" required value="${editCategory.name}"
                               placeholder="e.g. Spring Boot, Tailwind CSS"
                               class="w-full bg-slate-50 border border-slate-200 rounded-xl px-4 py-3 text-xs font-semibold text-slate-700 focus:outline-none focus:border-indigo-500 transition-all">
                    </div>
                    
                    <div class="flex items-center gap-2 pt-2">
                        <button type="submit" class="flex-1 text-center font-bold text-xs text-white py-3 rounded-xl transition-all shadow-md ${not empty editCategory ? 'bg-amber-500 hover:bg-amber-600 shadow-amber-500/20' : 'bg-indigo-600 hover:bg-indigo-700 shadow-indigo-600/20'}">
                            <c:choose>
                                <c:when test="${not empty editCategory}">Update Category</c:when>
                                <c:otherwise>Save Category</c:otherwise>
                            </c:choose>
                        </button>
                        
                        <c:if test="${not empty editCategory}">
                            <a href="manage-categories" class="bg-slate-100 hover:bg-slate-200 text-slate-500 px-4 py-3 rounded-xl text-xs font-bold transition">Cancel</a>
                        </c:if>
                    </div>
                </form>
            </div>

            <div class="lg:col-span-2 bg-white rounded-[2.5rem] border border-slate-100 shadow-xl overflow-hidden">
                <div class="p-6 border-b border-slate-50 flex items-center justify-between">
                    <h3 class="text-base font-black text-slate-800">Available Categories</h3>
                    <span class="bg-indigo-50 text-indigo-600 px-3 py-1 rounded-full text-[10px] font-black uppercase tracking-wider">Total: ${categoryList.size()}</span>
                </div>
                
                <div class="overflow-y-auto max-h-[550px]">
                    <table class="w-full text-left">
                        <thead class="bg-slate-50 sticky top-0 z-10">
                            <tr>
                                <th class="px-8 py-4 text-[10px] font-black uppercase text-slate-400">Category Details</th>
                             
                                <th class="px-8 py-4 text-[10px] font-black uppercase text-slate-400 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-50">
                            <c:choose>
                                <c:when test="${empty categoryList}">
                                    <tr>
                                        <td colspan="3" class="p-12 text-center text-slate-400 font-bold text-xs">
                                            <i class="fa-solid fa-folder-open text-3xl block mb-2 text-slate-300"></i> No categories found. Create one.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="cat" items="${categoryList}">
                                        <tr class="hover:bg-slate-50/50 transition-colors">
                                            <td class="px-8 py-4">
                                                <div class="flex items-center gap-4">
                                                    <div class="w-9 h-9 rounded-xl bg-slate-100 text-slate-400 flex items-center justify-center">
                                                        <i class="fa-solid fa-folder text-sm text-indigo-500"></i>
                                                    </div>
                                                    <div>
                                                        <p class="text-sm font-bold text-slate-800">${cat.name}</p>
                                                    </div>
                                                </div>
                                            </td>
                                            
                                            <td class="px-8 py-4 text-right">
                                                <a href="manage-categories?editId=${cat.id}" 
                                                   class="inline-flex items-center justify-center w-9 h-9 rounded-xl bg-slate-100 text-slate-500 hover:bg-amber-500 hover:text-white transition-all shadow-sm"
                                                   title="Edit Name">
                                                    <i class="fa-solid fa-pen-to-square text-xs"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </main>

</body>
</html>