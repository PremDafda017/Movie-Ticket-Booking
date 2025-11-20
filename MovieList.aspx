<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MovieList.aspx.cs" Inherits="Movie_Ticket_Booking.MovieList" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Movie List - User Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            text-align: center;
        }

        h2 {
            color: #007bff;
            margin-bottom: 20px;
            font-size: 2em;
        }

        #lblWelcome {
            display: block;
            margin-bottom: 20px;
            font-size: 1.2em;
        }

        .grid-container {
            overflow-x: auto; /* Allows horizontal scrolling on small screens */
            margin-top: 20px;
        }

        /* Updated selectors to target the actual GridView IDs */
        #gvUsers, #gvMovies, #gvBookings {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        #gvUsers th, #gvUsers td,
        #gvMovies th, #gvMovies td,
        #gvBookings th, #gvBookings td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        #gvUsers th,
        #gvMovies th,
        #gvBookings th {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }

        #gvUsers tr:hover,
        #gvMovies tr:hover,
        #gvBookings tr:hover {
            background-color: #f1f1f1;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .container {
                padding: 10px;
            }

            h2 {
                font-size: 1.5em;
            }

            #lblWelcome {
                font-size: 1em;
            }

            #gvUsers th, #gvUsers td,
            #gvMovies th, #gvMovies td,
            #gvBookings th, #gvBookings td {
                padding: 8px;
                font-size: 0.9em;
            }
        }

        @media (max-width: 480px) {
            h2 {
                font-size: 1.3em;
            }

            #gvUsers th, #gvUsers td,
            #gvMovies th, #gvMovies td,
            #gvBookings th, #gvBookings td {
                padding: 6px;
                font-size: 0.8em;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>All Database Data</h2>
            <asp:Label ID="lblWelcome" runat="server" Font-Bold="true" ForeColor="Blue"></asp:Label>
            <br /><br />

            <h3>Users</h3>
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="true" BorderWidth="1px" CssClass="table table-striped" 
                DataKeyNames="UserID" OnRowDeleting="gvUsers_RowDeleting">
                <Columns>
                    <asp:CommandField ShowDeleteButton="true" />
                </Columns>
            </asp:GridView>

            <h3>Movies</h3>
            <asp:GridView ID="gvMovies" runat="server" AutoGenerateColumns="true" BorderWidth="1px" CssClass="table table-striped" 
                DataKeyNames="MovieID" OnRowDeleting="gvMovies_RowDeleting">
                <Columns>
                    <asp:CommandField ShowDeleteButton="true" />
                </Columns>
            </asp:GridView>

            <h3>Bookings</h3>
            <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="true" BorderWidth="1px" CssClass="table table-striped" 
                DataKeyNames="BookingID" OnRowDeleting="gvBookings_RowDeleting">
                <Columns>
                    <asp:CommandField ShowDeleteButton="true" />
                </Columns>
            </asp:GridView>

            <br />
            <asp:Button ID="btnBack" runat="server" Text="Back to Home" CssClass="btn btn-secondary" OnClick="btnBack_Click" />
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>