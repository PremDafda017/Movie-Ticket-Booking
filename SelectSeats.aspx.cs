using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace Movie_Ticket_Booking
{
    public partial class SelectSeats : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
            @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True");

        public class SeatInfo
        {
            public char Row { get; set; }
            public int Col { get; set; }
            public int Price { get; set; }
        }

        private List<SeatInfo> SelectedSeats
        {
            get { return Session["SelectedSeats"] as List<SeatInfo> ?? new List<SeatInfo>(); }
            set { Session["SelectedSeats"] = value; }
        }

        private int AllowedSeats
        {
            get { return ViewState["AllowedSeats"] != null ? (int)ViewState["AllowedSeats"] : 0; }
            set { ViewState["AllowedSeats"] = value; }
        }

        protected string ShowPopup
        {
            get { return ViewState["ShowPopup"]?.ToString() ?? "true"; }
            set { ViewState["ShowPopup"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("HomePage.aspx"); // Redirect if not logged in
                }

                // Load selected movie & theatre from session
                lblMovieTitle.Text = Session["SelectedMovieTitle"]?.ToString() ?? "Movie Not Selected";
                lblTheatre.Text = Session["SelectedTheatre"]?.ToString() ?? "Theatre Not Selected";
                lblDateTime.Text = $"{Session["SelectedDate"]?.ToString() ?? "-"} | {Session["SelectedShowtime"]?.ToString() ?? "-"}";

                // Populate dropdowns from hardcoded data (since Theatres and Showtimes tables don't exist)
                PopulateTheatres();
                PopulateShowtimes();
            }

            if (AllowedSeats > 0)
            {
                GenerateSeatLayout();
            }
        }

        private void PopulateTheatres()
        {
            // Hardcoded theatres since Theatres table doesn't exist
            ddlTheatre.Items.Clear();
            ddlTheatre.Items.Add(new ListItem("PVR Cinemas", "PVR Cinemas"));
            ddlTheatre.Items.Add(new ListItem("INOX", "INOX"));
            ddlTheatre.Items.Add(new ListItem("Cinepolis", "Cinepolis"));
        }

        private void PopulateShowtimes()
        {
            // Hardcoded showtimes since Showtimes table doesn't exist
            ddlShowtime.Items.Clear();
            ddlShowtime.Items.Add(new ListItem("10:00 AM", "10:00 AM"));
            ddlShowtime.Items.Add(new ListItem("1:00 PM", "1:00 PM"));
            ddlShowtime.Items.Add(new ListItem("4:00 PM", "4:00 PM"));
            ddlShowtime.Items.Add(new ListItem("7:00 PM", "7:00 PM"));
        }

        protected void btnStart_Click(object sender, EventArgs e)
        {
            AllowedSeats = int.Parse(ddlSeats.SelectedValue);
            SelectedSeats = new List<SeatInfo>();
            ShowPopup = "false"; // Do not show popup again
            GenerateSeatLayout();
        }

        private void GenerateSeatLayout()
        {
            phSeats.Controls.Clear();

            // Platinum
            phSeats.Controls.Add(new Literal { Text = "<h5 class='section-title'>Platinum - ₹500</h5>" });
            CreateSeatRow('A', 8, 500);
            CreateSeatRow('B', 8, 500);

            // Gold
            phSeats.Controls.Add(new Literal { Text = "<h5 class='section-title'>Gold - ₹300</h5>" });
            CreateSeatRow('C', 10, 300);
            CreateSeatRow('D', 10, 300);
            CreateSeatRow('E', 10, 300);
            CreateSeatRow('F', 10, 300);

            // Silver
            phSeats.Controls.Add(new Literal { Text = "<h5 class='section-title'>Silver - ₹200</h5>" });
            CreateSeatRow('G', 15, 200);
            CreateSeatRow('H', 15, 200);
            CreateSeatRow('I', 15, 200);
            CreateSeatRow('J', 15, 200);
        }

        private void CreateSeatRow(char rowChar, int numSeats, int price)
        {
            var div = new HtmlGenericControl("div");
            div.Attributes["class"] = "seat-row";
            div.Controls.Add(new Literal { Text = $"<span class='row-label'>{rowChar}</span>" });

            for (int c = 1; c <= numSeats; c++)
            {
                Button btn = new Button();
                btn.Text = c.ToString();
                btn.CommandArgument = $"{rowChar}|{c}|{price}";

                SeatInfo tempSeat = new SeatInfo { Row = rowChar, Col = c, Price = price };
                btn.CssClass = IsSeatAlreadySelected(tempSeat) ? "seat-btn selected" : "seat-btn available";

                btn.Click += Seat_Click;
                div.Controls.Add(btn);
            }

            phSeats.Controls.Add(div);
        }

        protected void Seat_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            if (string.IsNullOrEmpty(btn.CommandArgument)) return;

            string[] parts = btn.CommandArgument.Split('|');
            char row = parts[0][0];
            int col = int.Parse(parts[1]);
            int price = int.Parse(parts[2]);

            SeatInfo seat = new SeatInfo { Row = row, Col = col, Price = price };
            var seats = SelectedSeats;

            if (IsSeatAlreadySelected(seat))
            {
                seats.RemoveAll(s => s.Row == row && s.Col == col);
                btn.CssClass = "seat-btn available";
            }
            else
            {
                if (seats.Count >= AllowedSeats)
                {
                    lblMsg.Text = $"You can select only {AllowedSeats} seats.";
                    return;
                }
                seats.Add(seat);
                btn.CssClass = "seat-btn selected";
            }

            SelectedSeats = seats;
            lblMsg.Text = "";
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            if (SelectedSeats.Count != AllowedSeats)
            {
                lblMsg.Text = $"Please select exactly {AllowedSeats} seats.";
                return;
            }

            // Save booked seats in session
            Session["BookedSeats"] = SelectedSeats;
            Response.Redirect("Payment.aspx");
        }

        private bool IsSeatAlreadySelected(SeatInfo s)
        {
            foreach (var sel in SelectedSeats)
                if (sel.Row == s.Row && sel.Col == s.Col)
                    return true;
            return false;
        }
    }
}