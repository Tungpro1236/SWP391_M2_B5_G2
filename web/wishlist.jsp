<div class="container py-5">
    <h1 class="text-center mb-5">Danh s�ch y�u th�ch</h1>

    <c:choose>
        <c:when test="${not empty wishlistItems}">
            <div class="wishlist-items">
                <div class="card p-4">
                    <c:forEach items="${wishlistItems}" var="item">
                        <div class="card mb-3 course-card">
                            <div class="row g-0">
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title">${item.title}</h5>
                                        <p class="card-text text-success fw-bold">$${item.price}</p>
                                    </div>
                                </div>
                                <div class="col-md-4 d-flex align-items-center justify-content-end">
                                    <!-- N�t X�a kh?i Wishlist -->
                                    <form action="CartServlet" method="post" class="me-2">
                                        <input type="hidden" name="action" value="removeFromWishlist"/>
                                        <input type="hidden" name="courseId" value="${item.courseId}"/>
                                        <button type="submit" class="btn btn-danger">
                                            <i class="bi bi-trash"></i> X�a
                                        </button>
                                    </form>

                                    <!-- N�t Th�m v�o Gi? h�ng -->
                                    <form action="CartServlet" method="post" class="me-2">
                                        <input type="hidden" name="action" value="addFromWishlist"/>
                                        <input type="hidden" name="courseId" value="${item.courseId}"/>
                                        <button type="submit" class="btn btn-success">
                                            <i class="bi bi-cart-plus"></i> Th�m v�o Gi? h�ng
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info text-center">
                <i class="bi bi-heart-x empty-wishlist-icon"></i>
                <h4 class="mt-3">Danh s�ch y�u th�ch tr?ng</h4>
                <p>H�y th�m kh�a h?c y�u th�ch v�o danh s�ch!</p>
                <a href="CourseController" class="btn btn-primary mt-2">
                    <i class="bi bi-book"></i> Xem kh�a h?c
                </a>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- N�t quay l?i danh s�ch kh�a h?c -->
    <a href="CourseController" class="btn btn-secondary mt-3">
        <i class="bi bi-arrow-left"></i> Quay l?i danh s�ch kh�a h?c
    </a>

    <!-- N�t chuy?n ??n l?ch s? Wishlist -->
    <a href="HistoryWishlistController" class="btn btn-info mt-3">
        <i class="bi bi-clock-history"></i> L?ch s? Wishlist
    </a>
</div>
