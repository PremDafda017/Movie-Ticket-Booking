using System;
using System.Collections.Generic;

namespace Movie_Ticket_Booking
{
    public partial class MovieDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string movie = Request.QueryString["movie"];

                if (string.IsNullOrEmpty(movie))
                {
                    lblTitle.Text = "Movie Not Found";
                    return;
                }

                movie = movie.Trim().ToUpper().Replace(" ", "");
                var movieData = GetMovieData(movie);

                if (movieData != null)
                {
                    lblTitle.Text = movieData.Title;
                    lblGenre.Text = movieData.Genre;
                    lblLanguage.Text = movieData.Language;
                    lblDuration.Text = movieData.Duration;
                    lblDescription.Text = movieData.Description;
                    imgPoster.ImageUrl = movieData.ImageUrl;

                    Session["SelectedMovie"] = movieData;
                }
                else
                {
                    lblTitle.Text = "Movie Not Found";
                }
            }
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            if (Session["SelectedMovie"] != null)
            {
                var movie = (Movie)Session["SelectedMovie"];

                // Save selected movie, theatre, and showtime to session
                Session["SelectedMovieTitle"] = movie.Title;
                Session["SelectedTheatre"] = ddlTheatre.SelectedValue;
                Session["SelectedDate"] = DateTime.Now.ToString("dd MMM yyyy");
                Session["SelectedShowtime"] = ddlShowtime.SelectedValue;

                Response.Redirect("SelectSeats.aspx");
            }
        }

        private Movie GetMovieData(string movie)
        {
            var movies = new Dictionary<string, Movie>(StringComparer.OrdinalIgnoreCase)
            {
                ["KGF2"] = new Movie { Title = "KGF 2", Genre = "Action/Drama", Language = "Hindi", Duration = "2h 38m", Description = "The blood-soaked land of Kolar Gold Fields has a new overlord now...", ImageUrl = "img/kgf2.jpeg" },
                ["SAIYAARA"] = new Movie { Title = "Saiyaara", Genre = "Comedy/Romantic", Language = "Hindi", Duration = "2h 10m", Description = "A light-hearted romantic comedy about unexpected love.", ImageUrl = "img/saiyaara.jpeg" },
                ["COOLIE"] = new Movie { Title = "Coolie", Genre = "Thriller", Language = "Hindi", Duration = "2h 25m", Description = "An intense thriller unraveling a gripping mystery.", ImageUrl = "img/Coolie.jpeg" },
                ["BAJRANGIBHAIJAAN"] = new Movie { Title = "Bajrangi Bhaijaan", Genre = "Drama", Language = "Hindi", Duration = "2h 40m", Description = "A heartfelt drama about a man’s journey to reunite a little girl with her family.", ImageUrl = "img/bajarangi%20Bhaijaan.jpeg" },
                ["PK"] = new Movie { Title = "PK", Genre = "Fantasy", Language = "Hindi", Duration = "2h 33m", Description = "An alien questions human society and religion in this satirical comedy.", ImageUrl = "img/PK.jpg" },
                ["DHAMAAL"] = new Movie { Title = "Dhamaal", Genre = "Comedy", Language = "Hindi", Duration = "2h 10m", Description = "A fun-filled comedy about four friends on a treasure hunt.", ImageUrl = "img/Dhamaal.jpeg" },

                ["STREAM1"] = new Movie { Title = "Stream Show 1", Genre = "Drama/Action", Language = "English", Duration = "Episode ~45m", Description = "The latest episode from the trending series is now available.", ImageUrl = "https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC:w-400.0,h-660.0,cm-pad_resize,bg-000000,fo-top:l-text,ie-U2F0LCAyNyBTZXAgb253YXJkcw%3D%3D,fs-29,co-FFFFFF,ly-612,lx-24,pa-8_0_0_0,l-end/et00355125-ezdkbntsdb-portrait.jpg" },

                ["STREAM2"] = new Movie { Title = "Stream Show 2", Genre = "Live Event", Language = "English/Hindi", Duration = "Ongoing", Description = "Catch the live streaming event happening right now!", ImageUrl = "https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC:w-400.0,h-660.0,cm-pad_resize,bg-000000,fo-top:l-text,ie-VGh1LCAyMyBPY3Qgb253YXJkcw%3D%3D,fs-29,co-FFFFFF,ly-612,lx-24,pa-8_0_0_0,l-end/et00409716-qzdfrlqywb-portrait.jpg" },

                ["STREAM3"] = new Movie { Title = "Stream Show 3", Genre = "Trending/Popular", Language = "Multi-Language", Duration = "Episode ~50m", Description = "One of the most trending shows right now, don’t miss it!", ImageUrl = "https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC:w-400.0,h-660.0,cm-pad_resize,bg-000000,fo-top:l-text,ie-U2F0LCAxIE5vdg%3D%3D,fs-29,co-FFFFFF,ly-612,lx-24,pa-8_0_0_0,l-end/et00456671-nvtkjlbdbt-portrait.jpg" }

            };

            movies.TryGetValue(movie, out Movie selectedMovie);
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