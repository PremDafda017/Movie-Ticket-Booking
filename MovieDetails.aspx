<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MovieDetails.aspx.cs" Inherits="Movie_Ticket_Booking.MovieDetails" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Movie Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #ff8a00, #e52e71);
            --secondary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --card-bg: rgba(255, 255, 255, 0.95);
            --shadow-light: 0 4px 15px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 8px 25px rgba(0, 0, 0, 0.2);
            --text-primary: #333;
            --text-secondary: #666;
            --accent-yellow: #FFDF20;
        }

        body {
            background: var(--secondary-gradient);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--text-primary);
            overflow-x: hidden;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 1200px;
            margin-top: 20px;
            animation: fadeInUp 0.8s ease-out;
        }

        .row {
            background: var(--card-bg);
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow-hover);
            backdrop-filter: blur(10px);
            margin-bottom: 40px;
        }

        /* Poster Image */
        .col-md-4 img {
            width: 100%;
            height: 500px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: var(--shadow-light);
            transition: all 0.3s ease;
            cursor: pointer;
        }

            .col-md-4 img:hover {
                transform: scale(1.02);
                box-shadow: var(--shadow-hover);
            }

        /* Movie Details Section */
        .col-md-8 {
            padding-left: 30px;
        }

            .col-md-8 h2 {
                color: var(--text-primary);
                font-weight: 700;
                margin-bottom: 20px;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.1);
                letter-spacing: 1px;
            }

            .col-md-8 p {
                font-size: 1.1rem;
                margin-bottom: 15px;
                color: var(--text-secondary);
            }

            .col-md-8 strong {
                color: var(--text-primary);
                font-weight: 600;
            }

            /* Description Paragraph */
            .col-md-8 p:last-of-type {
                font-style: italic;
                line-height: 1.6;
                color: var(--text-primary);
                background: rgba(255, 255, 255, 0.5);
                padding: 15px;
                border-radius: 10px;
                border-left: 4px solid var(--primary-gradient);
            }

        /* Form Controls (Dropdowns) */
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 2px solid #ddd;
            transition: all 0.3s ease;
            font-size: 1rem;
            background: rgba(255, 255, 255, 0.9);
            width: 100% !important; /* Override w-50 for better mobile fit */
        }

            .form-control:focus {
                border-color: var(--primary-gradient);
                box-shadow: 0 0 0 0.2rem rgba(229, 46, 113, 0.25);
                transform: scale(1.02);
                background: #fff;
            }

            .form-control option {
                padding: 10px;
                background: #fff;
            }

        /* Book Button */
        .btn-danger {
            background: var(--primary-gradient);
            border: none;
            border-radius: 25px;
            padding: 12px 30px;
            font-weight: bold;
            font-size: 1.1rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow-light);
            color: #fff !important;
            width: 100%;
            max-width: 200px;
        }

            .btn-danger:hover {
                transform: translateY(-3px) scale(1.05);
                box-shadow: var(--shadow-hover);
                background: linear-gradient(135deg, #e52e71, #ff8a00);
                color: #fff !important;
            }

        /* Section Labels (Theatre, Showtime) */
        .col-md-8 p strong {
            display: block;
            margin-bottom: 8px;
            color: var(--text-primary);
            font-size: 1.2rem;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .row {
                padding: 20px;
                margin: 10px;
                border-radius: 15px;
            }

            .col-md-8 {
                padding-left: 0;
                padding-top: 20px;
            }

            .col-md-4 img {
                height: 350px;
                margin-bottom: 20px;
            }

            .col-md-8 h2 {
                font-size: 1.8rem;
                text-align: center;
            }

            .col-md-8 p {
                font-size: 1rem;
                text-align: justify;
            }

            .form-control {
                margin-bottom: 15px;
            }

            .btn-danger {
                max-width: 100%;
                margin-top: 10px;
            }
        }

        @media (max-width: 480px) {
            .container {
                margin-top: 10px;
                padding: 0 10px;
            }

            .row {
                padding: 15px;
            }

            .col-md-4 img {
                height: 250px;
            }

            .col-md-8 h2 {
                font-size: 1.5rem;
            }

            .col-md-8 p {
                font-size: 0.95rem;
            }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }

        ::-webkit-scrollbar-thumb {
            background: var(--primary-gradient);
            border-radius: 10px;
        }

            ::-webkit-scrollbar-thumb:hover {
                background: #e52e71;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <div class="row">
                <div class="col-md-4">
                    <asp:Image ID="imgPoster" runat="server" CssClass="img-fluid" />
                </div>
                <div class="col-md-8">
                    <h2><asp:Label ID="lblTitle" runat="server" /></h2>
                    <p><strong>Genre:</strong> <asp:Label ID="lblGenre" runat="server" /></p>
                    <p><strong>Language:</strong> <asp:Label ID="lblLanguage" runat="server" /></p>
                    <p><strong>Duration:</strong> <asp:Label ID="lblDuration" runat="server" /></p>
                    <p><strong>Description:</strong></p>
                    <p><asp:Label ID="lblDescription" runat="server" /></p>

                    <!-- Theatre Selection -->
                    <p><strong>Select Theatre:</strong></p>
                    <asp:DropDownList ID="ddlTheatre" runat="server" CssClass="form-control mb-2">
                        <asp:ListItem Text="Cinepolis: Nexus Seawoods, Nerul, Navi Mumbai" Value="Cinepolis: Nexus Seawoods, Nerul, Navi Mumbai" />
                        <asp:ListItem Text="Cinepolis: Viviana Mall, Thane" Value="Cinepolis: Viviana Mall, Thane" />
                        <asp:ListItem Text="INOX: R City Mall, Ghatkopar" Value="INOX: R City Mall, Ghatkopar" />
                    </asp:DropDownList>

                    <!-- Showtime Selection -->
                    <p><strong>Select Show Time:</strong></p>
                    <asp:DropDownList ID="ddlShowtime" runat="server" CssClass="form-control mb-2">
                        <asp:ListItem Text="10:30 AM" Value="10:30 AM" />
                        <asp:ListItem Text="02:30 PM" Value="02:30 PM" />
                        <asp:ListItem Text="07:30 PM" Value="07:30 PM" />
                    </asp:DropDownList>

                    <asp:Button ID="btnBook" runat="server" Text="Book Tickets" CssClass="btn btn-danger mt-3" OnClick="btnBook_Click" />
                </div>
            </div>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
