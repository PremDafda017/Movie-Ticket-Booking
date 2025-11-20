<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="Movie_Ticket_Booking.Payment" 
    UnobtrusiveValidationMode="None" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment - Movie Ticket Booking</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body { background: #f8f9fa; min-height: 100vh; }
        .card { border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); margin-bottom: 20px; }
        .total { font-weight: bold; color: #28a745; font-size: 1.3rem; }
        .btn-pay { background-color: #28a745; color: #fff; font-weight: bold; }
        .btn-pay:hover { background-color: #218838; }
        .form-floating { margin-bottom: 1rem; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8">

                    <!-- Booking Summary -->
                    <div class="card p-3">
                        <h4>Booking Summary</h4>
                        <hr />
                        <p>Movie: <asp:Label ID="lblMovieTitle" runat="server" /></p>
                        <p>Theatre: <asp:Label ID="lblTheatre" runat="server" /></p>
                        <p>Date & Time: <asp:Label ID="lblDateTime" runat="server" /></p>
                        <p>Seats: <asp:Label ID="lblSeatList" runat="server" /></p>
                        <h5 class="total">Total: ₹<asp:Label ID="lblTotalAmount" runat="server" /></h5>
                    </div>

                    <!-- Payment Form -->
                    <div class="card p-3">
                        <h4>Payment Details</h4>
                        <asp:ValidationSummary ID="valSummary" runat="server" CssClass="text-danger" />

                        <div class="form-floating">
                            <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" placeholder="Card Number" MaxLength="19" />
                            <label for="txtCardNumber">Card Number</label>
                            <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" ControlToValidate="txtCardNumber"
                                ErrorMessage="Card number is required" CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <div class="form-floating">
                            <asp:TextBox ID="txtNameOnCard" runat="server" CssClass="form-control" placeholder="Name on Card" />
                            <label for="txtNameOnCard">Name on Card</label>
                            <asp:RequiredFieldValidator ID="rfvNameOnCard" runat="server" ControlToValidate="txtNameOnCard"
                                ErrorMessage="Name is required" CssClass="text-danger" Display="Dynamic" />
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <asp:TextBox ID="txtExpiry" runat="server" CssClass="form-control" placeholder="MM/YY" MaxLength="5" />
                                    <label for="txtExpiry">Expiry (MM/YY)</label>
                                    <asp:RequiredFieldValidator ID="rfvExpiry" runat="server" ControlToValidate="txtExpiry"
                                        ErrorMessage="Expiry required" CssClass="text-danger" Display="Dynamic" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-floating">
                                    <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" placeholder="CVV" MaxLength="3" TextMode="Password" />
                                    <label for="txtCVV">CVV</label>
                                    <asp:RequiredFieldValidator ID="rfvCVV" runat="server" ControlToValidate="txtCVV"
                                        ErrorMessage="CVV required" CssClass="text-danger" Display="Dynamic" />
                                </div>
                            </div>
                        </div>

                        <asp:Label ID="lblMsg" runat="server" CssClass="text-danger" />

                        <asp:Button ID="btnPayNow" runat="server" CssClass="btn btn-pay w-100" Text="Pay Now" OnClick="btnPayNow_Click" />
                    </div>

                </div>
            </div>
        </div>
    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Format card number
        document.getElementById('<%= txtCardNumber.ClientID %>').addEventListener('input', function (e) {
            let v = e.target.value.replace(/\D/g, '');
            e.target.value = v.match(/.{1,4}/g)?.join(' ') || v;
        });

        // Format expiry
        document.getElementById('<%= txtExpiry.ClientID %>').addEventListener('input', function (e) {
            let v = e.target.value.replace(/\D/g, '');
            if (v.length > 2) v = v.slice(0, 2) + '/' + v.slice(2, 4);
            e.target.value = v;
        });
    </script>
</body>
</html>
