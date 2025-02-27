<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="holidays.aspx.cs" Inherits="hrms.holidays" %>

<%@ Register Src="~/left_navbar.ascx" TagName="LeftNavBar" TagPrefix="uc" %>
<%@ Register Src="~/header_navbar.ascx" TagName="HeaderNavBar" TagPrefix="uc" %>
<%@ Register Src="~/quick_action.ascx" TagName="Quick_action" TagPrefix="uc" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Holiday Calendar</title>

    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/searchpanes/2.1.2/css/searchPanes.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/select/1.6.2/css/select.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />

    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
    <script src="https://cdn.datatables.net/searchpanes/2.1.2/js/dataTables.searchPanes.min.js"></script>
    <script src="https://cdn.datatables.net/select/1.6.2/js/dataTables.select.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

    <style>
        .main-container {
            display: flex;
            min-height: 100vh;
            transition: all 0.3s ease-in-out;
        }

        .left-navbar {
            width: 15%;
        }

            .left-navbar.toggled {
                width: 70px;
            }

        .content-container {
            flex-grow: 1;
            margin-left: 0;
            transition: margin-left 0.3s ease;
        }

        #Quickaction-container {
            position: fixed;
            right: 5px;
            bottom: 10px;
            user-select: none;
            z-index: 1050;
            cursor: pointer;
        }

        .calendar {
            background-color: #808080;
            color: white;
            border-radius: 10px;
            padding: 20px;
            height: 700px;
            overflow-y: auto;
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }

            .calendar-header button {
                background-color: #444;
                color: white;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                visibility: visible;
            }

        .calendar-table {
            width: 100%;
            border-collapse: collapse;
        }

            .calendar-table th, .calendar-table td {
                padding: 25px;
                text-align: center;
                font-weight: 700;
                font-size: 1.5rem;
            }

            .calendar-table td {
                cursor: pointer;
            }

                .calendar-table td:hover {
                    background-color: #555;
                }

        #editModal textarea {
            width: 100%;
            height: 100%;
            padding: 10px;
            box-sizing: border-box;
        }


        @keyframes slideInFromRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }

            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .alert-custom {
            animation: slideInFromRight 0.5s ease-out;
        }

        #greenAlert {
            display: none;
            position: fixed;
            top: 60px;
            right: 20px;
            z-index: 1050;
            width: 500px;
            height: 60px;
            border-left: 5px solid #28a745;
            padding-left: 15px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 0;
            opacity: 0;
            transition: opacity 2s ease-in-out;
        }
    </style>
</head>
<body style="background-color: #f8f9fa">
    <input type="hidden" id="emp_access_lvl" name="emp_access_lvl" runat="server" />

    <div id="greenAlert" style="display: none; align-items: center;" class="alert alert-success alert-dismissible fade alert-custom" role="alert">
        <strong><i class="fa-sharp fa-solid fa-circle-exclamation ml-1 mr-3"></i></strong><span id="greenAlertmessage"></span>
    </div>
    <div class="main-container">
        <div id="sidebarContainer" class="left-navbar">
            <uc:LeftNavBar runat="server" />
        </div>

        <div id="content-container" class="content-container">
            <div class="header-container">
                <uc:HeaderNavBar runat="server" />
            </div>
            <div class="d-flex align-items-center justify-content-between bg-light p-3 mt-4 ml-4 mr-3">
                <h1 style="font-family: 'Roboto', sans-serif; color: #333; font-size: 2.5rem;" class="m-0">Holiday Calendar</h1>
            </div>
            <div class="mt-3">
                <div class="wrapper" style="margin-left: 40px; margin-right: 40px">
                    <div id="calendar" class="calendar">
                        <div class="calendar-header mb-2">
                            <button class="prev-month">Prev</button>
                            <h2 id="month-name">January 2025</h2>
                            <button class="next-month">Next</button>
                        </div>
                        <table class="calendar-table">
                            <thead>
                                <tr>
                                    <th>Sun</th>
                                    <th>Mon</th>
                                    <th>Tue</th>
                                    <th>Wed</th>
                                    <th>Thu</th>
                                    <th>Fri</th>
                                    <th>Sat</th>
                                </tr>
                            </thead>
                            <tbody id="calendar-body">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div id="Quickaction-container">
                <uc:Quick_action runat="server" />
            </div>
        </div>
    </div>

    <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header mt-1 pb-2" style="background-color: transparent; border-bottom: none;">
                    <h5 class="modal-title ml-1" id="editModalHeader"></h5>
                    <button type="button" style="border: none; outline: none" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <textarea id="edit-text" placeholder="Enter data for the date"></textarea>
                </div>
                <div class="modal-footer" style="border: none">
                    <button type="button" class="btn btn-primary" style="background-color: #ff3b38; border: none; outline: none" onclick="saveData()">Save</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            fetchHolidays(currentMonth, currentYear);
        });

        function display_green_alert(message) {
            document.getElementById("greenAlert").style.display = 'flex';
            document.getElementById("greenAlertmessage").innerHTML = message;
            $('#greenAlert').fadeIn(500).css('opacity', '1').delay(3000).fadeOut(2000);
        }

        let currentMonth = new Date().getMonth();
        let currentYear = new Date().getFullYear();
        let holidayCache = {};
        let holidayData = {};

        $(".prev-month").click(() => changeMonth(-1));
        $(".next-month").click(() => changeMonth(1));

        function changeMonth(step) {
            currentMonth += step;
            if (currentMonth < 0) { currentMonth = 11; currentYear--; }
            if (currentMonth > 11) { currentMonth = 0; currentYear++; }

            if (holidayCache[`${currentYear}-${currentMonth}`]) {
                createCalendar(currentMonth, currentYear, holidayCache[`${currentYear}-${currentMonth}`]);
            } else {
                fetchHolidays(currentMonth, currentYear);
            }
        }

        function fetchHolidays(month, year) {
            $.ajax({
                type: "POST",
                url: "holidays.aspx/GetHolidays",
                data: JSON.stringify({ month: month + 1, year: year }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.includes("ExceptionMessage")) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: response.d,
                            confirmButtonText: 'Ok'
                        });
                        return;
                    }

                    holidayData = response.d ? JSON.parse(response.d) : {};
                    holidayCache[`${year}-${month}`] = holidayData;
                    createCalendar(month, year, holidayData);
                },
                error: function () {
                    console.error("Error fetching holiday data.");
                }
            });
        }

        function createCalendar(month, year, holidayData) {
            $("#calendar-body").empty();
            $("#month-name").text(`${new Date(year, month).toLocaleString('default', { month: 'long' })} ${year}`);

            let firstDay = new Date(year, month, 1).getDay();
            let daysInMonth = new Date(year, month + 1, 0).getDate();
            let currentDay = 1;

            for (let i = 0; i < 6; i++) {
                let row = $("<tr></tr>");
                for (let j = 0; j < 7; j++) {
                    let cell = $("<td></td>");
                    if ((i === 0 && j < firstDay) || currentDay > daysInMonth) {
                        row.append(cell);
                        continue;
                    }

                    let fullDate = `${year}-${String(month + 1).padStart(2, '0')}-${String(currentDay).padStart(2, '0')}`;
                    cell.text(currentDay);

                    if (holidayData[fullDate]) {
                        cell.append($(`<div class="holiday-exists mt-1" style="color: hsl(8, 77%, 85%)">${holidayData[fullDate]}</div>`));
                    }

                    if ($("#emp_access_lvl").val() == "true") {
                        cell.click(() => openEditModal(fullDate));
                    }
                    row.append(cell);
                    currentDay++;
                }
                $("#calendar-body").append(row);
            }
        }

        function openEditModal(date) {
            selectedDate = date;
            $("#editModalHeader").text(`Edit Holiday - ${date}`);

            if (holidayData[date]) {
                $("#edit-text").val(holidayData[date]);
                $(".btn-primary").text("Edit");
            } else {
                $("#edit-text").val("");
                $(".btn-primary").text("Save");
            }

            $("#editModal").modal("show");
        }

        function saveData() {
            const holidayName = $("#edit-text").val().trim();
            if (!holidayName) return;

            const isEdit = holidayData[selectedDate] ? true : false;

            $.ajax({
                type: "POST",
                url: "holidays.aspx/SaveHoliday",
                data: JSON.stringify({ date: selectedDate, data: holidayName, isEdit: isEdit }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    if (response.d.includes("ExceptionMessage")) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: response.d,
                            confirmButtonText: 'Ok'
                        });
                        return;
                    }

                    $("#editModal").modal("hide");
                    fetchHolidays(currentMonth, currentYear);
                    display_green_alert(`The holiday have been saved successfully.`);
                },
                error: function () {
                    display_green_alert(`Failed to save holiday.`);
                }
            });
        }

    </script>

</body>
</html>
