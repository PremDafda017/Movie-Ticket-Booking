using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace Movie_Ticket_Booking
{
    public partial class Payment : Page
    {
        SqlConnection con = new SqlConnection(
            @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["username"] == null)
                {
                    Response.Redirect("HomePage.aspx"); // Redirect if not logged in
                }
                LoadBookingSummary();
            }
        }

        private void LoadBookingSummary()
        {
            // Get movie and theatre from session
            lblMovieTitle.Text = Session["SelectedMovieTitle"]?.ToString() ?? "Movie";
            lblTheatre.Text = Session["SelectedTheatre"]?.ToString() ?? "Theatre";
            lblDateTime.Text = $"{Session["SelectedDate"]?.ToString()} | {Session["SelectedShowtime"]?.ToString()}";

            // Get booked seats
            var seats = Session["BookedSeats"] as List<SelectSeats.SeatInfo>;
            if (seats == null || seats.Count == 0)
            {
                lblMsg.Text = "No seats selected!";
                btnPayNow.Visible = false;
                return;
            }

            lblSeatList.Text = string.Join(", ", seats.Select(s => $"{s.Row}{s.Col}"));
            lblTotalAmount.Text = seats.Sum(s => s.Price).ToString("F0");
        }

        protected void btnPayNow_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            // Simulate payment success
            Session["PaymentDetails"] = new
            {
                CardLast4 = txtCardNumber.Text.Replace(" ", "").Substring(txtCardNumber.Text.Replace(" ", "").Length - 4),
                Name = txtNameOnCard.Text
            };

            // Get user ID from session username
            int userId = GetUserId(Session["username"].ToString());
            if (userId == -1)
            {
                lblMsg.Text = "User not found. Please log in again.";
                return;
            }

            // Get movie ID (insert movie if not found)
            int movieId = GetMovieId(Session["SelectedMovieTitle"].ToString());
            if (movieId == -1)
            {
                // Movie not found, insert it into DB
                movieId = InsertMovieIfNotExists(Session["SelectedMovieTitle"].ToString());
                if (movieId == -1)
                {
                    lblMsg.Text = "Error inserting movie.";
                    return;
                }
            }

            // Get theatre, showtime, date from session
            string theatre = Session["SelectedTheatre"].ToString();
            string showtime = Session["SelectedShowtime"].ToString();
            string date = Session["SelectedDate"].ToString();
            var seats = Session["BookedSeats"] as List<SelectSeats.SeatInfo>;
            string seatList = string.Join(",", seats.Select(s => $"{s.Row}{s.Col}"));
            int totalAmount = seats.Sum(s => s.Price);
            string paymentStatus = "Paid"; // Set payment status to Paid

            // Generate booking summary string
            string bookingSummary = $"Movie: {Session["SelectedMovieTitle"]}, Theatre: {theatre}, Date & Time: {date} | {showtime}, Seats: {seatList}, Total Amount: ₹{totalAmount}, Payment Status: {paymentStatus}";

            // Insert booking into DB (including summary)
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Bookings (UserID, MovieID, Theatre, ShowDate, Showtime, Seats, Amount, PaymentStatus, Summary) VALUES (@UserID, @MovieID, @Theatre, @ShowDate, @Showtime, @Seats, @Amount, @PaymentStatus, @Summary)", con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@MovieID", movieId);
                cmd.Parameters.AddWithValue("@Theatre", theatre);
                cmd.Parameters.AddWithValue("@ShowDate", date);
                cmd.Parameters.AddWithValue("@Showtime", showtime);
                cmd.Parameters.AddWithValue("@Seats", seatList);
                cmd.Parameters.AddWithValue("@Amount", totalAmount);
                cmd.Parameters.AddWithValue("@PaymentStatus", paymentStatus);
                cmd.Parameters.AddWithValue("@Summary", bookingSummary);
                cmd.ExecuteNonQuery();
                con.Close();

                // Clear booking sessions
                Session.Remove("BookedSeats");
                Session.Remove("SelectedMovieTitle");
                Session.Remove("SelectedTheatre");
                Session.Remove("SelectedDate");
                Session.Remove("SelectedShowtime");

                // Redirect to MovieList.aspx to display summaries
                Response.Redirect("MovieList.aspx");
            }
            catch (Exception ex)
            {
                lblMsg.Text = $"Error saving booking: {ex.Message}";
                return;
            }
        }

        private int GetUserId(string username)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT UserID FROM Users WHERE Name = @Name", con);
                cmd.Parameters.AddWithValue("@Name", username);
                object result = cmd.ExecuteScalar();
                con.Close();
                return result != null ? (int)result : -1;
            }
            catch
            {
                return -1;
            }
        }

        private int GetMovieId(string title)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT MovieID FROM Movies WHERE Title = @Title", con);
                cmd.Parameters.AddWithValue("@Title", title);
                object result = cmd.ExecuteScalar();
                con.Close();
                return result != null ? (int)result : -1;
            }
            catch
            {
                return -1;
            }
        }

        private int InsertMovieIfNotExists(string title)
        {
            // Get movie data from hardcoded list (same as MovieDetails.aspx.cs)
            var movieData = GetMovieData(title);
            if (movieData == null) return -1;

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Movies (Title, Genre, Language, Duration, Description, ImageUrl) VALUES (@Title, @Genre, @Language, @Duration, @Description, @ImageUrl); SELECT SCOPE_IDENTITY();", con);
                cmd.Parameters.AddWithValue("@Title", movieData.Title);
                cmd.Parameters.AddWithValue("@Genre", movieData.Genre);
                cmd.Parameters.AddWithValue("@Language", movieData.Language);
                cmd.Parameters.AddWithValue("@Duration", movieData.Duration);
                cmd.Parameters.AddWithValue("@Description", movieData.Description);
                cmd.Parameters.AddWithValue("@ImageUrl", movieData.ImageUrl);
                object result = cmd.ExecuteScalar();
                con.Close();
                return result != null ? Convert.ToInt32(result) : -1;
            }
            catch
            {
                return -1;
            }
        }

        private Movie GetMovieData(string title)
        {
            var movies = new Dictionary<string, Movie>(StringComparer.OrdinalIgnoreCase)
            {
                ["KGF 2"] = new Movie { Title = "KGF 2", Genre = "Action/Drama", Language = "Hindi", Duration = "2h 38m", Description = "The blood-soaked land of Kolar Gold Fields has a new overlord now...", ImageUrl = "img/kgf2.jpeg" },
                ["Saiyaara"] = new Movie { Title = "Saiyaara", Genre = "Comedy/Romantic", Language = "Hindi", Duration = "2h 10m", Description = "A light-hearted romantic comedy about unexpected love.", ImageUrl = "img/saiyaara.jpeg" },
                ["Coolie"] = new Movie { Title = "Coolie", Genre = "Thriller", Language = "Hindi", Duration = "2h 25m", Description = "An intense thriller unraveling a gripping mystery.", ImageUrl = "img/Coolie.jpeg" },
                ["Bajrangi Bhaijaan"] = new Movie { Title = "Bajrangi Bhaijaan", Genre = "Drama", Language = "Hindi", Duration = "2h 40m", Description = "A heartfelt drama about a man’s journey to reunite a little girl with her family.", ImageUrl = "img/bajarangi%20Bhaijaan.jpeg" },
                ["PK"] = new Movie { Title = "PK", Genre = "Fantasy", Language = "Hindi", Duration = "2h 33m", Description = "An alien questions human society and religion in this satirical comedy.", ImageUrl = "img/PK.jpg" },
                ["Dhamaal"] = new Movie { Title = "Dhamaal", Genre = "Comedy", Language = "Hindi", Duration = "2h 10m", Description = "A fun-filled comedy about four friends on a treasure hunt.", ImageUrl = "img/Dhamaal.jpeg" },
                ["Stream Show 1"] = new Movie { Title = "Stream Show 1", Genre = "Drama/Action", Language = "English", Duration = "Episode ~45m", Description = "The latest episode from the trending series is now available.", ImageUrl = "https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC:w-400.0,h-660.0,cm-pad_resize,bg-000000,fo-top:l-text,ie-U2F0LCAyNyBTZXAgb253YXJkcw%3D%3D,fs-29,co-FFFFFF,ly-612,lx-24,pa-8_0_0_0,l-end/et00355125-ezdkbntsdb-portrait.jpg" },
                ["Stream Show 2"] = new Movie { Title = "Stream Show 2", Genre = "Live Event", Language = "English/Hindi", Duration = "Ongoing", Description = "Catch the live streaming event happening right now!", ImageUrl = "https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC:w-400.0,h-660.0,cm-pad_resize,bg-000000,fo-top:l-text,ie-VGh1LCAyMyBPY3Qgb253YXJkcw%3D%3D,fs-29,co-FFFFFF,ly-612,lx-24,pa-8_0_0_0,l-end/et00409716-qzdfrlqywb-portrait.jpg" },
                ["Stream Show 3"] = new Movie { Title = "Stream Show 3", Genre = "Trending/Popular", Language = "Multi-Language", Duration = "Episode ~50m", Description = "One of the most trending shows right now, don’t miss it!", ImageUrl = "https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC:w-400.0,h-660.0,cm-pad_resize,bg-000000,fo-top:l-text,ie-U2F0LCAxIE5vdg%3D%3D,fs-29,co-FFFFFF,ly-612,lx-24,pa-8_0_0_0,l-end/et00456671-nvtkjlbdbt-portrait.jpg" }
            };

            movies.TryGetValue(title, out Movie selectedMovie);
            return selectedMovie;
        }

        public class Movie
        {
            public string Title { get; set; }
            public string Genre { get; set; }
            public string Language { get; set; }
            public string Duration { get; set; }
            public string Description { get; set; }
            public string ImageUrl { get; set; }
        }
    }
}