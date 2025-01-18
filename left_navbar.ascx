<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="left_navbar.ascx.cs" Inherits="hrms.left_navbar" %>


<style>
    .sidebar-item a {
        text-decoration: none;
        display: flex;
        align-items: center;
        padding: 10px 20px;
        color: white;
        font-size: 15px;
    }

    .sidebar-menu-icon i {
        font-size: 20px; 
    }

    .sidebar-item a:hover .sidebar-menu-icon,
    .sidebar-item a:hover span {
        color: rgba(255, 255, 255, 0.8);
    }
</style>
<div class="sidebar text-white" style="background-color: #2f2f2f; position: -webkit-sticky; position: sticky; top: 0; height: 100vh; overflow-x: hidden;">

    <div class="sidebar-company" style="padding: 20px; border-bottom: 1px solid rgba(255,255,255,0.7);">
        <div class="sidebar-company-details">
            <div class="d-flex align-items-center">
                <img src="\asset\hrms_icon.jpg" class="rounded-circle"
                    style="width: 36px; height: 34px; object-fit: cover;">
                <div class="ml-2">
                    <div class="font-weight-bold" style="font-size: 13px;">HRMS.</div>
                    <a class="d-block" style="font-size: 10px; color: rgba(255,255,255,0.7)">My company</a>
                </div>
            </div>
        </div>
    </div>

    <div class="sidebar-menu m-3">
        <ul class="sidebar-items" style="list-style-type: none; padding: 0;">
            <li class="sidebar-item">
                <a onclick="window.location.href=this.href; return false;" class="sidebar-menu-link" data-id="dashboardNav">
                    <div class="sidebar-menu-icon mr-2">
                        <i class="fa-solid fa-address-card"></i>
                    </div>
                    <span class="mb-2">Dashboard</span>
                </a>
            </li>
        </ul>
    </div>
</div>


