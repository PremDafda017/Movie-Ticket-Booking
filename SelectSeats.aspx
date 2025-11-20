<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectSeats.aspx.cs" Inherits="Movie_Ticket_Booking.SelectSeats" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Select Seats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        :root {
            --primary-color: #28a745;
            --secondary-color: #ffc107;
            --danger-color: #dc3545;
            --bg-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --seat-available: #e8f5e8;
            --seat-selected: #28a745;
            --seat-sold: #ddd;
            --shadow-light: 0 4px 15px rgba(0,0,0,0.1);
            --shadow-hover: 0 6px 20px rgba(0,0,0,0.15);
        }

        body {
            background: var(--bg-gradient);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .movie-header {
            background: rgba(255,255,255,0.95);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: var(--shadow-light);
            backdrop-filter: blur(10px);
            animation: fadeInDown 0.8s ease-out;
        }

            .movie-header h4 {
                color: var(--primary-color);
                font-weight: 700;
                margin-bottom: 10px;
                text-align: center;
            }

            .movie-header p {
                text-align: center;
                color: #666;
                font-size: 1.1rem;
            }

        .theater-section {
            background: rgba(255,255,255,0.95);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: var(--shadow-light);
            backdrop-filter: blur(10px);
            animation: fadeInUp 0.8s ease-out 0.2s both;
        }

        .screen {
            background: linear-gradient(180deg, #333 0%, #555 100%);
            height: 80px;
            border-radius: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
            font-weight: bold;
            box-shadow: inset 0 4px 10px rgba(0,0,0,0.3);
            animation: slideIn 0.6s ease-out;
        }

        .seats-container {
            max-height: 500px;
            overflow-y: auto;
            padding: 10px;
            border-radius: 10px;
            background: rgba(255,255,255,0.7);
        }

        .section-title {
            font-weight: 600;
            margin: 20px 0 10px;
            color: var(--primary-color);
            text-align: center;
            animation: fadeIn 0.5s ease-out;
        }

        .seat-row {
            display: flex;
            align-items: center;
            margin: 4px 0;
            justify-content: center;
            animation: slideInRow 0.4s ease-out;
        }

        .row-label {
            width: 30px;
            text-align: right;
            margin-right: 10px;
            font-weight: bold;
            color: #555;
            min-width: 30px;
        }

        .seat-btn {
            width: 40px;
            height: 40px;
            margin: 2px;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 0.8rem;
            font-weight: bold;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
            overflow: hidden;
            box-shadow: var(--shadow-light);
        }

            .seat-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
                transition: left 0.5s;
            }

            .seat-btn:hover::before {
                left: 100%;
            }

            .seat-btn.available {
                background: var(--seat-available);
                color: #28a745;
            }

                .seat-btn.available:hover {
                    background: var(--primary-color);
                    color: white;
                    transform: scale(1.05);
                    box-shadow: var(--shadow-hover);
                    border-color: var(--primary-color);
                }

            .seat-btn.selected {
                background: var(--seat-selected);
                color: white;
                animation: pulse 0.6s ease-out;
                border-color: #1e7e34;
                box-shadow: 0 0 15px rgba(40, 167, 69, 0.5);
            }

                .seat-btn.selected:hover {
                    transform: scale(1.05);
                    box-shadow: 0 0 20px rgba(40, 167, 69, 0.7);
                }

            .seat-btn.sold {
                background: var(--seat-sold);
                color: #999;
                border-color: #ccc;
                cursor: not-allowed;
                opacity: 0.6;
            }

                .seat-btn.sold:hover {
                    transform: none;
                    box-shadow: none;
                }

        .legend {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 20px 0;
            flex-wrap: wrap;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 0.9rem;
        }

        .legend-color {
            width: 20px;
            height: 20px;
            border-radius: 4px;
            border: 2px solid #ddd;
        }

        .btn-confirm {
            background: linear-gradient(135deg, var(--primary-color), #1e7e34);
            border: none;
            padding: 12px 30px;
            font-weight: bold;
            border-radius: 25px;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-light);
            width: 100%;
            max-width: 200px;
        }

            .btn-confirm:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-hover);
                color: white;
            }

        .modal-content {
            border-radius: 15px;
            border: none;
            box-shadow: var(--shadow-hover);
            animation: modalSlideIn 0.4s ease-out;
        }

        .modal-header {
            background: var(--bg-gradient);
            color: white;
            border-radius: 15px 15px 0 0;
            border: none;
        }

        .modal-body {
            padding: 30px;
        }

        .modal-footer {
            border: none;
            padding: 20px 30px 30px;
        }

        #lblMsg {
            display: block;
            text-align: center;
            font-weight: bold;
            animation: shake 0.5s ease-in-out;
        }


        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                padding: 10px;
            }

            .movie-header, .theater-section {
                padding: 15px;
            }

            .seat-btn {
                width: 35px;
                height: 35px;
                font-size: 0.75rem;
            }

            .seat-row {
                justify-content: flex-start;
                padding-left: 10px;
            }

            .legend {
                flex-direction: column;
                align-items: center;
                gap: 10px;
            }

            .seats-container {
                max-height: 400px;
            }

            .screen {
                height: 60px;
                font-size: 1rem;
            }
        }

        @media (max-width: 480px) {
            .seat-btn {
                width: 30px;
                height: 30px;
                margin: 1px;
            }

            .row-label {
                width: 25px;
                font-size: 0.9rem;
            }
        }

        /* Scrollbar Styling for Innovation */
        .seats-container::-webkit-scrollbar {
            width: 8px;
        }

        .seats-container::-webkit-scrollbar-track {
            background: rgba(255,255,255,0.5);
            border-radius: 10px;
        }

        .seats-container::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 10px;
        }

            .seats-container::-webkit-scrollbar-thumb:hover {
                background: #1e7e34;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-container">
            <div class="movie-header">
                <h4><asp:Label ID="lblMovieTitle" runat="server" /></h4>
                <p><asp:Label ID="lblTheatre" runat="server" /><br />
                   <asp:Label ID="lblDateTime" runat="server" /></p>
                <!-- Added dropdowns for theatre and showtime (hidden by default; set Visible="true" if needed for re-selection) -->
                <asp:DropDownList ID="ddlTheatre" runat="server" Visible="false" CssClass="form-control w-50 mx-auto mt-2"></asp:DropDownList>
                <asp:DropDownList ID="ddlShowtime" runat="server" Visible="false" CssClass="form-control w-50 mx-auto mt-2"></asp:DropDownList>
            </div>

            <div class="section-title">Seat Layout</div>

            <div class="legend">
                <div class="legend-item">
                    <div class="legend-color" style="background: var(--seat-available);"></div>
                    <span>Available</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color" style="background: var(--seat-selected);"></div>
                    <span>Selected</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color" style="background: var(--seat-sold);"></div>
                    <span>Sold</span>
                </div>
            </div>

            <div class="seats-container">
                <asp:PlaceHolder ID="phSeats" runat="server"></asp:PlaceHolder>
            </div>
            <div class="theater-section">
                <div class="screen">
                    <i class="fas fa-tv"></i> SCREEN
                </div>
            </div>

            <div class="text-center mt-3">
                <asp:Label ID="lblMsg" runat="server" ForeColor="Red" />
            </div>

            <div class="text-center mt-3">
                <asp:Button ID="btnConfirm" runat="server" Text="Confirm Booking" CssClass="btn btn-success btn-confirm"
                            OnClick="btnConfirm_Click" />
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="seatModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><i class="fas fa-chair me-2"></i>How many seats do you want?</h5>
                    </div>
                    <div class="modal-body text-center">
                        <asp:DropDownList ID="ddlSeats" runat="server" CssClass="form-control w-50 mx-auto" Style="border-radius: 25px; padding: 10px;">
                            <asp:ListItem Text="1" Value="1" />
                            <asp:ListItem Text="2" Value="2" />
                            <asp:ListItem Text="3" Value="3" />
                            <asp:ListItem Text="4" Value="4" />
                            <asp:ListItem Text="5" Value="5" />
                            <asp:ListItem Text="6" Value="6" />
                            <asp:ListItem Text="7" Value="7" />
                            <asp:ListItem Text="8" Value="8" />
                        </asp:DropDownList>
                        <p class="mt-3 text-muted">Choose the number of seats for your group.</p>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnStart" runat="server" Text="Continue" CssClass="btn btn-primary" OnClick="btnStart_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        window.onload = function () {
            var showPopup = '<%= ShowPopup %>';
            if (showPopup === "true") {
                var myModal = new bootstrap.Modal(document.getElementById('seatModal'), {
                    backdrop: 'static',
                    keyboard: false
                });
                myModal.show();
            }
            const seatsContainer = document.querySelector('.seats-container');
            if (seatsContainer) {
                seatsContainer.addEventListener('scroll', function() {
                    this.style.scrollBehavior = 'smooth';
                });
            }
            const maxSeats = parseInt('<%= ddlSeats.SelectedValue ?? "0" %>') || 0;
            if (maxSeats > 0) {
                document.querySelectorAll('.seat-btn.available').forEach(btn => {
                    btn.addEventListener('click', function (e) {
                        if (document.querySelectorAll('.seat-btn.selected').length >= maxSeats) {
                            e.preventDefault();
                            alert('You have reached the maximum number of seats!');
                        }
                    });
                });
            }
        };
    </script>
</body>
</html>