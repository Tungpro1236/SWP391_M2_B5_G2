<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html dir="ltr" lang="zxx">

        <head>

            <meta http-equiv="content-type" content="text/html; charset=utf-8">
            <meta name="author" content="flexkit">

            <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon">
            <link rel="preconnect" href="https://fonts.gstatic.com">

            <!-- Fonts -->
            <link
                href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
                rel="stylesheet">
            <link href="https://fonts.googleapis.com/css2?family=Allura&display=swap" rel="stylesheet">

            <!-- Stylesheets -->
            <link rel="stylesheet" href="css/plugins/swiper.min.css" type="text/css">
            <link rel="stylesheet" href="css/plugins/jquery.fancybox.css" type="text/css">
            <link rel="stylesheet" href="css/style.css" type="text/css">

            <meta name="viewport" content="width=device-width, initial-scale=1">
            <!--[if lt IE 9]>
          <script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
        <![endif]-->

            <!-- Document Title -->
            <title>Online Learning</title>

        </head>

        <body>

            <main>
                <div class="mb-4 pb-4"></div>
                <section class="cd-position-relative cd-z-index-1 cd-padding-y-2xl">
                    <div class="cd-container cd-max-width-adaptive-sm cd-text-center">
                        <svg class="cd-icon thank-you__icon cd-margin-bottom-sm" viewBox="0 0 96 96" aria-hidden="true">
                            <g fill="currentColor">
                                <circle cx="48" cy="48" r="48" opacity=".1"></circle>
                                <circle cx="48" cy="48" r="31" opacity=".2"></circle>
                                <circle cx="48" cy="48" r="15" opacity=".3"></circle>
                                <path fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"
                                    stroke-width="2" d="M40 48.5l5 5 11-11"></path>
                                <path transform="rotate(25.474 70.507 8.373)" opacity=".5"
                                    d="M68.926 4.12h3.159v8.506h-3.159z"></path>
                                <path transform="rotate(-52.869 17.081 41.485)" opacity=".5"
                                    d="M16.097 36.336h1.969v10.298h-1.969z"></path>
                                <path transform="rotate(82.271 75.128 61.041)" opacity=".5"
                                    d="M74.144 57.268h1.969v7.547h-1.969z"></path>
                                <circle cx="86.321" cy="41.45" r="2.946" opacity=".5"></circle>
                                <circle cx="26.171" cy="78.611" r="1.473" opacity=".5"></circle>
                                <circle cx="49.473" cy="9.847" r="1.473" opacity=".5"></circle>
                                <circle cx="10.283" cy="63" r="2.946" opacity=".2"></circle>
                                <path opacity=".4" d="M59.948 88.142l10.558-3.603-4.888-4.455-5.67 8.058z"></path>
                                <path opacity=".3" d="M18.512 19.236l5.667 1.456.519-8.738-6.186 7.282z"></path>
                            </g>
                        </svg>

                        <div>
                            <h1 class="cd-margin-bottom-xs">Thank you!</h1>
                            <p class="thank-you__paragraph cd-margin-bottom-xs">Lorem ipsum dolor sit amet consectetur
                                adipisicing elit</p>

                            <p><a class="cd-link" href="CourseController">Continue</a></p>
                        </div>
                    </div>
                </section>
            </main>
            <style>
                /* reset */
                *,
                *::after,
                *::before {
                    box-sizing: border-box;
                }

                * {
                    font: inherit;
                    margin: 0;
                    padding: 0;
                    border: 0;
                }

                html {
                    -webkit-font-smoothing: antialiased;
                    -moz-osx-font-smoothing: grayscale;
                }

                body {
                    background-color: hsl(0, 0%, 100%);
                    font-family: system-ui, sans-serif;
                    color: hsl(230, 7%, 23%);
                    font-size: 1.125rem;
                    /* 18px */
                    line-height: 1.4;
                }

                h1,
                h2,
                h3,
                h4 {
                    line-height: 1.2;
                    color: hsl(230, 13%, 9%);
                    font-weight: 700;
                }

                h1 {
                    font-size: 2.5rem;
                    /* 40px */
                }

                h2 {
                    font-size: 2.125rem;
                    /* 34px */
                }

                h3 {
                    font-size: 1.75rem;
                    /* 28px */
                }

                h4 {
                    font-size: 1.375rem;
                    /* 22px */
                }

                ol,
                ul,
                menu {
                    list-style: none;
                }

                button,
                input,
                textarea,
                select {
                    background-color: transparent;
                    border-radius: 0;
                    color: inherit;
                    line-height: inherit;
                    -webkit-appearance: none;
                    appearance: none;
                }

                textarea {
                    resize: vertical;
                    overflow: auto;
                    vertical-align: top;
                }

                a {
                    color: hsl(250, 84%, 54%);
                }

                table {
                    border-collapse: collapse;
                    border-spacing: 0;
                }

                img,
                video,
                svg {
                    display: block;
                    max-width: 100%;
                }

                /* -------------------------------- 
            
            Icons 
            
            -------------------------------- */

                .cd-icon {
                    --size: 1em;
                    font-size: var(--size);
                    height: 1em;
                    width: 1em;
                    display: inline-block;
                    color: inherit;
                    fill: currentColor;
                    line-height: 1;
                    flex-shrink: 0;
                    max-width: initial;
                }

                /* --------------------------------
            
            Component 
            
            -------------------------------- */

                .thank-you__icon {
                    --size: 96px;
                    color: hsl(170, 78%, 36%);
                }

                .thank-you__paragraph {
                    line-height: 1.4;
                    color: hsl(225, 4%, 47%);
                }

                /* -------------------------------- 
            
            Utilities 
            
            -------------------------------- */

                .cd-position-relative {
                    position: relative;
                }

                .cd-z-index-1 {
                    z-index: 1;
                }

                .cd-margin-bottom-xs {
                    margin-bottom: 1rem;
                }

                .cd-padding-y-2xl {
                    padding-top: 7rem;
                    padding-bottom: 7rem;
                }

                .cd-container {
                    width: calc(100% - 3rem);
                    margin-left: auto;
                    margin-right: auto;
                }

                .cd-max-width-adaptive-sm {
                    max-width: 32rem;
                }

                @media (min-width: 48rem) {
                    .cd-max-width-adaptive-sm {
                        max-width: 48rem;
                    }
                }

                .cd-text-center {
                    text-align: center;
                }

                /* link */
                .cd-link {
                    color: hsl(250, 84%, 54%);
                    text-decoration: none;
                    background-image: linear-gradient(to right, hsl(250, 84%, 54%) 50%, hsla(250, 84%, 54%, 0.2) 50%);
                    background-size: 200% 1px;
                    background-repeat: no-repeat;
                    background-position: 100% 100%;
                    transition: background-position 0.2s;
                }

                .cd-link:hover {
                    background-position: 0% 100%;
                }
            </style>
            <div class="mb-5 pb-xl-5"></div>


            <!-- Go To Top -->
            <div id="scrollTop" class="visually-hidden end-0"></div>

            <!-- Page Overlay -->
            <div class="page-overlay"></div><!-- /.page-overlay -->
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script>
                window.onload = function () {
                    Swal.fire({
                        title: 'Order Successfully!',
                        icon: 'success',
                        confirmButtonText: 'OK'
                    });
                }
            </script>


            <!-- External JavaScripts -->
            <script src="js/plugins/jquery.min.js"></script>
            <script src="js/plugins/bootstrap.bundle.min.js"></script>
            <script src="js/plugins/bootstrap-slider.min.js"></script>

            <script src="js/plugins/swiper.min.js"></script>
            <script src="js/plugins/countdown.js"></script>
            <script src="js/plugins/jquery.fancybox.js"></script>

            <!-- Footer Scripts -->
            <script src="js/theme.js"></script>

        </body>

        </html>