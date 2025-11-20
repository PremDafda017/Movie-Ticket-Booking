using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Movie_Ticket_Booking
{
    public partial class MovieList : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
            @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("HomePage.aspx");
                }
                else
                {
                    lblWelcome.Text = "Welcome, " + Session["username"].ToString();
                    DisplayAllData();
                }
            }
        }

        private void DisplayAllData()
        {
            try
            {
                con.Open();

                // Users
                SqlCommand cmdUsers = new SqlCommand("SELECT * FROM Users", con);
                SqlDataAdapter daUsers = new SqlDataAdapter(cmdUsers);
                DataTable dtUsers = new DataTable();
                daUsers.Fill(dtUsers);
                gvUsers.DataSource = dtUsers;
                gvUsers.DataBind();

                // Movies
                SqlCommand cmdMovies = new SqlCommand("SELECT * FROM Movies", con);
                SqlDataAdapter daMovies = new SqlDataAdapter(cmdMovies);
                DataTable dtMovies = new DataTable();
                daMovies.Fill(dtMovies);
                gvMovies.DataSource = dtMovies;
                gvMovies.DataBind();

                // Bookings with JOIN to Users for user name, including Summary
                SqlCommand cmdBookings = new SqlCommand(
                    "SELECT B.BookingID, U.Name AS UserName, B.MovieID, B.Theatre, B.ShowDate, B.Showtime, B.Seats, B.Amount, B.PaymentStatus, B.Summary " +
                    "FROM Bookings B INNER JOIN Users U ON B.UserID = U.UserID", con);
                SqlDataAdapter daBookings = new SqlDataAdapter(cmdBookings);
                DataTable dtBookings = new DataTable();
                daBookings.Fill(dtBookings);
                gvBookings.DataSource = dtBookings;
                gvBookings.DataBind();

                con.Close();
            }
            catch (Exception ex)
            {
                lblWelcome.Text = $"Error loading data: {ex.Message}";
            }
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
                con.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM Users WHERE UserID = @UserID", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.ExecuteNonQuery();
                con.Close();
                DisplayAllData(); // Refresh data
            }
            catch (Exception ex)
            {
                lblWelcome.Text = $"Error deleting user: {ex.Message}";
            }
        }

        protected void gvMovies_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int movieId = Convert.ToInt32(gvMovies.DataKeys[e.RowIndex].Value);
                con.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM Movies WHERE MovieID = @MovieID", con);
                cmd.Parameters.AddWithValue("@MovieID", movieId);
                cmd.ExecuteNonQuery();
                con.Close();
                DisplayAllData(); // Refresh data
            }
            catch (Exception ex)
            {
                lblWelcome.Text = $"Error deleting movie: {ex.Message}";
            }
        }

        protected void gvBookings_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int bookingId = Convert.ToInt32(gvBookings.DataKeys[e.RowIndex].Value);
                con.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM Bookings WHERE BookingID = @BookingID", con);
                cmd.Parameters.AddWithValue("@BookingID", bookingId);
                cmd.ExecuteNonQuery();
                con.Close();
                DisplayAllData(); // Refresh data
            }
            catch (Exception ex)
            {
                lblWelcome.Text = $"Error deleting booking: {ex.Message}";
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx");
        }
    }
}