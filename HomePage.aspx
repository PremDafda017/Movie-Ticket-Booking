<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Movie_Ticket_Booking.HomePage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Movie Ticket Booking - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<style>
    :root {
        --primary-gradient: linear-gradient(135deg, #ff8a00, #e52e71);
        --secondary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        --card-bg: rgba(255, 255, 255, 0.95);
        --shadow-light: 0 4px 15px rgba(0,0,0,0.1);
        --shadow-hover: 0 8px 25px rgba(0,0,0,0.2);
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
    }

    /* Navbar */
    .navbar {
        background: var(--primary-gradient);
        border-radius: 0 0 15px 15px;
        height: auto;
        padding: 10px 0;
        box-shadow: var(--shadow-light);
        position: sticky;
        top: 0;
        z-index: 1000;
        backdrop-filter: blur(10px);
        animation: slideDown 0.6s ease-out;
    }

    .navbar-brand {
        font-size: 1.8rem;
        font-weight: bold;
        color: #fff !important;
        letter-spacing: 1px;
        transition: transform 0.3s ease;
    }

    .navbar-brand:hover {
        transform: scale(1.05);
    }

    .navbar-nav .nav-link {
        font-weight: 600;
        color: #fff !important;
        margin: 0 15px;
        padding: 8px 16px;
        border-radius: 20px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
    }

    .navbar-nav .nav-link::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
        transition: left 0.5s;
    }

    .navbar-nav .nav-link:hover::before {
        left: 100%;
    }

    .navbar-nav .nav-link:hover {
        color: var(--accent-yellow) !important;
        transform: translateY(-2px);
        background: rgba(255,255,255,0.1);
    }

    .navbar .btn {
        border-radius: 25px;
        padding: 8px 20px;
        font-weight: bold;
        transition: all 0.3s ease;
        border: none;
        box-shadow: var(--shadow-light);
    }

    .navbar .btn:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow-hover);
    }

    .navbar .btn-primary {
        background: #fff;
        color: #e52e71;
    }

    .navbar .btn-primary:hover {
        background: #333;
        color: #fff;
    }

    .navbar .btn-danger {
        background: #dc3545;
        color: #fff;
    }

    /* Video Background Section */
    .video-background-section {
        position: relative;
        width: 100%;
        height: 400px;
        border-radius: 20px;
        overflow: hidden;
        margin: 20px 0;
        box-shadow: var(--shadow-hover);
        animation: fadeInUp 1s ease-out;
    }

    .video-bg {
        position: absolute;
        top: 50%;
        left: 50%;
        min-width: 100%;
        min-height: 100%;
        width: auto;
        height: auto;
        object-fit: cover;
        transform: translate(-50%, -50%);
        z-index: 0;
        filter: brightness(0.5) contrast(1.1);
        transition: filter 0.3s ease;
    }

    .video-background-section:hover .video-bg {
        filter: brightness(0.6) contrast(1.2);
    }

    .content-overlay {
        position: absolute;
        top: 90%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 1;
        color: white;
        text-align: center;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        animation: zoomIn 0.8s ease-out;
    }

    .content-overlay h2 {
        font-size: 3rem;
        font-weight: bold;
        margin-bottom: 10px;
        letter-spacing: 2px;
    }

    .content-overlay p {
        font-size: 1.3rem;
        opacity: 0.9;
    }

    /* Sections */
    .section-title {
        font-size: 2rem;
        font-weight: 700;
        color: #fff;
        text-align: center;
        margin: 40px 0 20px;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        animation: fadeInDown 0.6s ease-out;
    }

    /* Movie Cards */
    .movie-card {
        background: var(--card-bg);
        border: none;
        border-radius: 15px;
        padding: 15px;
        margin:10px 10px;
        box-shadow: var(--shadow-light);
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
        backdrop-filter: blur(5px);
    }

    .movie-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: var(--primary-gradient);
        transform: scaleX(0);
        transition: transform 0.3s ease;
    }

    .movie-card:hover::before {
        transform: scaleX(1);
    }

    .movie-card:hover {
        transform: translateY(-10px) scale(1.02);
        box-shadow: var(--shadow-hover);
        background: linear-gradient(135deg, #fff, var(--accent-yellow));
    }

    .movie-card img {
        height: 250px;
        width: 100%;
        object-fit: cover;
        border-radius: 10px;
        transition: all 0.3s ease;
        cursor: pointer;
    }

    .movie-card img:hover {
        transform: scale(1.05);
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }

    .movie-card h6 {
        font-weight: 600;
        margin: 10px 0 5px;
        color: var(--text-primary);
    }

    .movie-card p {
        font-size: 0.9rem;
        color: var(--text-secondary);
    }

    /* Stream and Events Cards */
    .stream-card, .category-card {
        background: var(--card-bg);
        border: none;
        border-radius: 15px;
        padding: 15px;
        margin: 10px 10px;
        box-shadow: var(--shadow-light);
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow: hidden;
        backdrop-filter: blur(5px);
        cursor: pointer;
    }

    .stream-card:hover, .category-card:hover {
        transform: translateY(-10px) scale(1.02);
        box-shadow: var(--shadow-hover);
        background: linear-gradient(135deg, #fff, var(--accent-yellow));
    }
    .stream-card img{
       height: 250px;
       width: 100%;
       object-fit: cover;
       border-radius: 10px;
       transition: all 0.3s ease;
       cursor: pointer;
    }
     .category-card img {
        width: 200%;
        height: 200px;
        object-fit: cover;
        border-radius: 10px;
        transition: all 0.3s ease;
    }

    .stream-card img:hover, .category-card img:hover {
        transform: scale(1.05);
    }

    /* Banner */
    .banner {
        background: var(--primary-gradient);
        color: #fff;
        border-radius: 20px;
        padding: 50px 20px;
        box-shadow: var(--shadow-hover);
        text-align: center;
        margin: 40px 0;
        animation: pulse 2s infinite;
        position: relative;
        overflow: hidden;
    }

    .banner::before {
        content: '';
        position: absolute;
        top: -50%;
        left: -50%;
        width: 200%;
        height: 200%;
        background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
        transform: rotate(45deg);
        animation: shine 3s infinite;
    }

    .banner h4 {
        font-size: 2.5rem;
        font-weight: bold;
        margin: 0;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        position: relative;
        z-index: 1;
    }

    /* Modals */
    .modal-content {
        border-radius: 20px;
        border: none;
        box-shadow: var(--shadow-hover);
        backdrop-filter: blur(10px);
        animation: modalSlideIn 0.4s ease-out;
    }

    .modal-header {
        background: var(--primary-gradient);
        color: #fff;
        border-radius: 20px 20px 0 0;
        border: none;
    }

    .modal-body {
        padding: 30px;
    }

    .modal-body .form-control {
        border-radius: 10px;
        padding: 12px;
        border: 2px solid #ddd;
        transition: border-color 0.3s ease;
    }

    .modal-body .form-control:focus {
        border-color: var(--primary-gradient);
        box-shadow: 0 0 0 0.2rem rgba(229, 46, 113, 0.25);
    }

    .modal-footer {
        border: none;
        padding: 20px 30px 30px;
    }

    #movies .row {
        display: flex;
        flex-wrap: nowrap;
        overflow-x: auto;
        padding-bottom: 10px;
    }

    #movies .movie-card {
        flex: 0 0 calc(100% / 6 - 0.5rem); 
        max-width: calc(100% / 6 - 0.5rem);
        margin-right: 0.5rem; 
        margin: 0 0.25rem; 
    }

    #movies .movie-card:last-child {
        margin-right: 0;
    }

    
    @media (max-width: 768px) {
        #movies .row {
            flex-wrap: wrap;
            overflow-x: visible;
        }
        
        #movies .movie-card {
            flex: 0 0 calc(50% - 0.5rem);
            max-width: calc(50% - 0.5rem);
            margin-right: 0.5rem;
            margin-bottom: 1rem;
        }
        
        #movies .movie-card:nth-child(even) {
            margin-right: 0;
        }
    }

    /* Animations */
    @keyframes slideDown {
        from { transform: translateY(-100%); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @keyframes fadeInDown {
        from { opacity: 0; transform: translateY(-30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @keyframes zoomIn {
        from { opacity: 0; transform: translate(-50%, -50%) scale(0.8); }
        to { opacity: 1; transform: translate(-50%, -50%) scale(1); }
    }

    @keyframes pulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.02); }
    }

    @keyframes shine {
        0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
        100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
    }

    @keyframes modalSlideIn {
        from { transform: scale(0.8); opacity: 0; }
        to { transform: scale(1); opacity: 1; }
    }

    /* Responsive Design */
    @media (max-width: 992px) {
        .navbar-nav .nav-link {
            margin: 5px 0;
        }

        .content-overlay h2 {
            font-size: 2.2rem;
        }

        .content-overlay p {
            font-size: 1.1rem;
        }

        .banner h4 {
            font-size: 2rem;
        }
    }

    @media (max-width: 768px) {
        .video-background-section {
            height: 300px;
        }

        .content-overlay h2 {
            font-size: 1.8rem;
        }

        .content-overlay p {
            font-size: 1rem;
        }

        .movie-card img, .stream-card img, .category-card img {
            height: 180px;
        }

        .movie-card, .stream-card, .category-card {
            margin: 5px;
            padding: 10px;
        }

        .section-title {
            font-size: 1.5rem;
        }

        .banner {
            padding: 30px 15px;
        }

        .banner h4 {
            font-size: 1.5rem;
        }

        .row {
            justify-content: center;
        }

        .movie-card, .stream-card, .category-card {
            flex: 0 0 calc(50% - 10px); /* 2 per row on mobile */
            max-width: calc(50% - 10px);
        }
    }

    @media (max-width: 480px) {
        .video-background-section {
            height: 250px;
            margin: 10px 0;
        }

        .movie-card img, .stream-card img, .category-card img {
            height: 150px;
        }

        .navbar-brand {
            font-size: 1.5rem;
        }
    }

    /* Custom Scrollbar */
    ::-webkit-scrollbar {
        width: 8px;
    }

    ::-webkit-scrollbar-track {
        background: rgba(255,255,255,0.1);
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
        <div class="container-fluid">
            <!-- Top Navigation -->
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm px-3">
                <a class="navbar-brand text-danger fw-bold" href="HomePage.aspx">🎟️ MovieBooking</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item"><a class="nav-link" href="#movies">Movies</a></li>
                        <li class="nav-item"><a class="nav-link" href="#stream">Stream</a></li>
                        <li class="nav-item"><a class="nav-link" href="#events">Events</a></li>
                    </ul>
                    <div>
                        <% if (Session["username"] == null) { %>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">Sign In</button>
                        <% } else { %>
                            <span class="me-2">👤 <%= Session["username"] %></span>
                            <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-danger" Text="Logout" OnClick="btnLogout_Click" />
                        <% } %>
                    </div>
                </div>
            </nav>

            <div class="video-background-section">
                <!-- Background video -->
                <video autoplay muted loop playsinline class="video-bg">
                    <source src="img/ex.mp4" type="video/mp4" />
                    Your browser does not support the video tag.
                </video>
                <!-- Foreground content -->
                <div class="content-overlay">
                    <h2>Now Showing</h2>
                    <p>Experience movies like never before 🍿</p>
                </div>
            </div>

            <!-- Recommended Movies -->
            <div class="container mt-4" id="movies">
                <h3 class="mb-3">🎬 Recommended Movies</h3>
                <div class="row g-3">
                    <div class="col-md-2 movie-card text-center">
                        <a href="MovieDetails.aspx?movie=KGF2">
                            <img src="img/kgf2.jpeg" class="img-fluid" alt="KGF 2" />
                        </a>
                        <h6>KGF 2</h6>
                        <p class="text-muted">Action/Drama</p>
                    </div>
                    <div class="col-md-2 movie-card text-center">
                        <a href="MovieDetails.aspx?movie=SAIYAARA">
                            <img src="img/saiyaara.jpeg" class="img-fluid" alt="SAIYAARA" />
                        </a>
                        <h6>SAIYAARA</h6>
                        <p class="text-muted">Comedy/Romantic</p>
                    </div>
                    <div class="col-md-2 movie-card text-center">
                        <a href="MovieDetails.aspx?movie=COOLIE">
                            <img src="img/Coolie.jpeg" class="img-fluid" alt="COOLIE" />
                        </a>
                        <h6>COOLIE</h6>
                        <p class="text-muted">Thriller</p>
                    </div>
                    <div class="col-md-2 movie-card text-center">
                        <a href="MovieDetails.aspx?movie=BAJRANGIBHAIJAAN">
                            <img src="img/bajarangi%20Bhaijaan.jpeg" class="img-fluid" alt="BAJRANGI BHAIJAAN" />
                        </a>
                        <h6>BAJRANGI BHAIJAAN</h6>
                        <p class="text-muted">Drama</p>
                    </div>
                    <div class="col-md-2 movie-card text-center">
                        <a href="MovieDetails.aspx?movie=PK">
                            <img src="img/PK.jpg" class="img-fluid" alt="PK" />
                        </a>
                        <h6>PK</h6>
                        <p class="text-muted">Fantasy</p>
                    </div>
                    <div class="col-md-2 movie-card text-center">
                        <a href="MovieDetails.aspx?movie=DHAMAAL">
                            <img src="img/Dhamaal.jpeg" class="img-fluid" alt="DHAMAAL" />
                        </a>
                        <h6>DHAMAAL</h6>
                        <p class="text-muted">Comedy</p>
                    </div>
                </div>
            </div>

            <!-- Stream Section -->
            <div class="container mt-5" id="stream">
                <h3 class="mb-3">📺 Latest Streaming</h3>
                <div class="row g-3">
                    <div class="col-md-3 movie-card text-center">
                        <a href="MovieDetails.aspx?movie=STREAM1">
                            <img src="https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC:w-400.0,h-660.0,cm-pad_resize,bg-000000,fo-top:l-text,ie-U2F0LCAyNyBTZXAgb253YXJkcw%3D%3D,fs-29,co-FFFFFF,ly-612,lx-24,pa-8_0_0_0,l-end/et00355125-ezdkbntsdb-portrait.jpg" class="img-fluid" alt="Stream 1" />
                        </a>
                        <h6>Stream Show 1</h6>
                        <p class="text-muted">New Episode</p>
                    </div>
                    <div class="col-md-3 movie-card text-center">
                        <a href="MovieDetails.aspx?movie=STREAM2">
                            <img src="https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC:w-400.0,h-660.0,cm-pad_resize,bg-000000,fo-top:l-text,ie-VGh1LCAyMyBPY3Qgb253YXJkcw%3D%3D,fs-29,co-FFFFFF,ly-612,lx-24,pa-8_0_0_0,l-end/et00409716-qzdfrlqywb-portrait.jpg" class="img-fluid" alt="Stream 2" />
                        </a>
                        <h6>Stream Show 2</h6>
                        <p class="text-muted">Live Now</p>
                    </div>
                    <div class="col-md-3 movie-card text-center">
                        <a href="MovieDetails.aspx?movie=STREAM3">
                            <img src="https://assets-in.bmscdn.com/discovery-catalog/events/tr:w-400,h-600,bg-CCCCCC:w-400.0,h-660.0,cm-pad_resize,bg-000000,fo-top:l-text,ie-U2F0LCAxIE5vdg%3D%3D,fs-29,co-FFFFFF,ly-612,lx-24,pa-8_0_0_0,l-end/et00456671-nvtkjlbdbt-portrait.jpg" class="img-fluid" alt="Stream 3" />
                        </a>
                        <h6>Stream Show 3</h6>
                        <p class="text-muted">Trending</p>
                    </div>
                </div>
            </div>

            <!-- Banner Section -->
            <div class="container-fluid mt-5">
                <div class="banner text-center">
                    <h4>🍿 Endless Entertainment Anytime. Anywhere!</h4>
                </div>
            </div>

            <!-- Categories / Events Section -->
            <div class="container mt-5" id="events">
                <h3 class="mb-3">✨ The Best of Live Events</h3>
                <div class="row text-center g-3">
                    <div class="col-md-2">
                        <div class="card category-card p-3 shadow-sm">
                            <img src="https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-800,h-800:l-text,ie-MTkwKyBFdmVudHM%3D,co-FFFFFF,ff-Roboto,fs-64,lx-48,ly-320,tg-b,pa-8_0_0_0,l-end/comedy-shows-collection-202211140440.png" class="img-fluid" alt="Comedy Shows" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="card category-card p-3 shadow-sm">
                            <img src="https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-800,h-800:w-300/icc-womens-2025-best-of-live-events-collection-202508300121.png" class="img-fluid" alt="Sports" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="card category-card p-3 shadow-sm">
                            <img src="https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-800,h-800:l-text,ie-MjArIEV2ZW50cw%3D%3D,co-FFFFFF,ff-Roboto,fs-64,lx-48,ly-320,tg-b,pa-8_0_0_0,l-end/amusement-parks-banner-desktop-collection-202503251132.png" class="img-fluid" alt="Amusement Parks" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="card category-card p-3 shadow-sm">
                            <img src="https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-800,h-800:l-text,ie-MTYwKyBFdmVudHM%3D,co-FFFFFF,ff-Roboto,fs-64,lx-48,ly-320,tg-b,pa-8_0_0_0,l-end/theatre-shows-collection-202211140440.png" class="img-fluid" alt="Theatre" />
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="card category-card p-3 shadow-sm">
                            <img src="https://assets-in.bmscdn.com/discovery-catalog/collections/tr:w-800,h-800:l-text,ie-MjUrIEV2ZW50cw%3D%3D,co-FFFFFF,ff-Roboto,fs-64,lx-48,ly-320,tg-b,pa-8_0_0_0,l-end/interactive-games-collection-202211140440.png" class="img-fluid" alt="Games" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Login Modal -->
            <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content p-3">
                        <div class="modal-header border-0">
                            <h5 class="modal-title" id="loginModalLabel">Login</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control mb-2" Placeholder="Username"></asp:TextBox>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control mb-2" Placeholder="Password" TextMode="Password"></asp:TextBox>
                            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-primary w-100" Text="Login" OnClick="btnLogin_Click" />
                        </div>
                        <div class="modal-footer border-0">
                            <p class="text-center w-100">Don't have an account? <a href="#" data-bs-toggle="modal" data-bs-target="#signupModal" data-bs-dismiss="modal">Sign Up</a></p>
                        </div>
                    </div>
                </div>
            </div>

                  <div class="modal fade" id="signupModal" tabindex="-1" aria-labelledby="signupModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content p-3">
                    <div class="modal-header border-0">
                        <h5 class="modal-title" id="signupModalLabel">Sign Up</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <asp:TextBox ID="txtSignupName" runat="server" CssClass="form-control mb-2" Placeholder="Name"></asp:TextBox>
                        <asp:TextBox ID="txtSignupEmail" runat="server" CssClass="form-control mb-2" Placeholder="Email"></asp:TextBox>
                        <asp:TextBox ID="txtSignupPassword" runat="server" CssClass="form-control mb-2" Placeholder="Password" TextMode="Password"></asp:TextBox>
                        <asp:Button ID="btnSignup" runat="server" CssClass="btn btn-success w-100" Text="Sign Up" OnClick="btnSignup_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
