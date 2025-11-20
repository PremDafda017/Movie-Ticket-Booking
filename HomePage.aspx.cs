using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Movie_Ticket_Booking
{
    public partial class HomePage : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
            @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Database1.mdf;Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // SIGNUP
        protected void btnSignup_Click(object sender, EventArgs e)
        {
            string name = txtSignupName.Text.Trim();
            string email = txtSignupEmail.Text.Trim();
            string password = txtSignupPassword.Text.Trim();

            if (name == "" || email == "" || password == "")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('All fields are required!');", true);
                return;
            }

            try
            {
                con.Open();
                SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email=@Email", con);
                check.Parameters.AddWithValue("@Email", email);
                int exists = (int)check.ExecuteScalar();

                if (exists > 0)
                {
                    con.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Email already registered!');", true);
                }
                else
                {
                    SqlCommand cmd = new SqlCommand("INSERT INTO Users(Name, Email, Password) VALUES(@Name, @Email, @Password)", con);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.ExecuteNonQuery();
                    con.Close();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Registered {name} successfully!');", true);
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
            }
        }

        // LOGIN
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT UserID, Name FROM Users WHERE Name=@Name AND Password=@Password", con);
                cmd.Parameters.AddWithValue("@Name", username);
                cmd.Parameters.AddWithValue("@Password", password);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    dr.Read();
                    Session["username"] = username;
                    Session["userid"] = dr["UserID"].ToString(); // Store UserID for FK
                    con.Close();
                    Response.Redirect("MovieList.aspx");
                }
                else
                {
                    con.Close();
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Invalid username or password!');", true);
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
            }
        }

        // LOGOUT
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("HomePage.aspx");
        }
    }
}