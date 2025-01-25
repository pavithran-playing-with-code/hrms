﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="testnavbar.ascx.cs" Inherits="hrms.testnavbar" %>

<nav id="quickaction-navbar" style="background-color: transparent !important;" class="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-primary p-0">
    <div class="inner-icons">
        <div class="icon-items-container">
            <div id="icon-item9" class="icon-item round" data-toggle="tooltip" data-placement="right" title="Dashboard Charts">
                <a class="text-light" data-toggle="oh-modal-toggle" data-target="#objectDetailsModal">
                    <i class="fas fa-chart-line"></i>
                </a>
            </div>

            <div id="icon-item8" class="icon-item round" data-toggle="tooltip" data-placement="right" title="Create Ticket">
                <a class="text-light">
                    <i class="fas fa-ticket-alt"></i>
                </a>
            </div>

            <div id="icon-item7" class="icon-item round" data-toggle="tooltip" data-placement="right" title="Create Asset Request">
                <a class="text-light">
                    <i class="fas fa-laptop"></i>
                </a>
            </div>

            <div id="icon-item6" class="icon-item round" data-toggle="tooltip" data-placement="right" title="Create Reimbursement">
                <a class="text-light">
                    <i class="fas fa-money-check-alt"></i>
                </a>
            </div>

            <div id="icon-item5" class="icon-item round" data-toggle="tooltip" data-placement="right" title="Create Work Type Request">
                <a class="text-light">
                    <i class="fas fa-briefcase"></i>
                </a>
            </div>

            <div id="icon-item4" class="icon-item round" data-toggle="tooltip" data-placement="right" title="Create Shift Request">
                <a class="text-light">
                    <i class="fas fa-history"></i>
                </a>
            </div>

            <div id="icon-item3" class="icon-item round" data-toggle="tooltip" data-placement="right" title="Create Leave Request">
                <a class="text-light">
                    <i class="fas fa-calendar-plus"></i>
                </a>
            </div>

            <div id="icon-item2" class="icon-item round" data-toggle="tooltip" data-placement="right" title="Create Attendance Request">
                <a class="text-light">
                    <i class="fas fa-user-check"></i>
                </a>
            </div>
        </div>
        <div id="icon-item1" class="icon-item round quick-action mt-1" data-toggle="tooltip" data-placement="right" title="Quick Action" onclick="toggleIcons()">
            <i id="quick-action-icon" class="fas fa-plus" style="font-size: 1.25rem;"></i>
        </div>
    </div>
</nav>

<style>
    .tooltip-inner {
        background-color: hsl(0, 0%, 13%) !important;
        color: white !important;
        font-size: 0.85rem;
        border-radius: 5px;
    }

    .tooltip.bs-tooltip-left .arrow::before {
        display: none !important;
    }

    .icon-item {
        width: 30px;
        height: 30px;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #ff3b38;
        border-radius: 50%;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease, opacity 0.3s ease;
        margin-bottom: 5px;
    }

        .icon-item:hover {
            transform: scale(1.1);
        }

        .icon-item i {
            font-size: 0.9rem;
            color: white;
        }

    .quick-action {
        width: 40px;
        height: 40px;
        position: relative;
        z-index: 2;
    }

    .inner-icons {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 5px;
        padding: 20px;
        position: relative;
        z-index: 1;
    }

    .icon-items-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 5px;
        transition: all 0.3s ease;
        opacity: 0;
        pointer-events: none;
        transform: translateY(50px);
        margin-top: 10px;
    }

        .icon-items-container.open {
            opacity: 1;
            pointer-events: all;
            transform: translateY(0);
        }

    #quick-action-icon {
        transition: transform 0.3s ease;
    }

    .quick-action.open i {
        transform: rotate(45deg);
    }
</style>

<script>
    $(document).ready(function () {
        $('[data-toggle="tooltip"]').tooltip(); // Initialize Bootstrap tooltips
    });

    function toggleIcons() {
        const container = document.querySelector('.icon-items-container');
        const quickActionButton = document.querySelector('.quick-action');

        container.classList.toggle('open');
        quickActionButton.classList.toggle('open');
    }
</script>
