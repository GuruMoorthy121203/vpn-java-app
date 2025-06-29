<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Lead</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px 0;
        }

        .container {
            max-width: 600px;
        }

        .main-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: none;
            overflow: hidden;
        }

        .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            text-align: center;
            border: none;
        }

        .card-header h2 {
            margin: 0;
            font-weight: 600;
            font-size: 1.8rem;
        }

        .card-header i {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            opacity: 0.9;
        }

        .card-body {
            padding: 2.5rem;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 0.5rem;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }

        .input-group {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            z-index: 10;
        }

        .form-control.with-icon {
            padding-left: 45px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
            border-radius: 10px;
            padding: 0.6rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(40, 167, 69, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
            border: none;
            border-radius: 10px;
            padding: 0.6rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 16px rgba(108, 117, 125, 0.3);
        }

        .divider {
            margin: 2rem 0;
            border: none;
            height: 2px;
            background: linear-gradient(to right, transparent, #e9ecef, transparent);
        }

        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .action-buttons .btn {
            flex: 1;
            min-width: 200px;
        }

        @media (max-width: 576px) {
            .container {
                padding: 0 15px;
            }
            
            .card-body {
                padding: 1.5rem;
            }
            
            .card-header {
                padding: 1.5rem;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .action-buttons .btn {
                min-width: auto;
            }
        }

        .form-floating {
            position: relative;
        }

        .form-floating > .form-control {
            height: calc(3.5rem + 2px);
            line-height: 1.25;
        }

        .form-floating > label {
            position: absolute;
            top: 0;
            left: 0;
            height: 100%;
            padding: 1rem 0.75rem;
            pointer-events: none;
            border: 1px solid transparent;
            transform-origin: 0 0;
            transition: opacity .1s ease-in-out,transform .1s ease-in-out;
        }

        .animate-on-load {
            animation: slideInUp 0.6s ease-out;
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card main-card animate-on-load">
            <div class="card-header">
                <i class="fas fa-user-plus"></i>
                <h2>Add New Lead</h2>
            </div>
            
            <div class="card-body">
                <form action="AddLeadServlet" method="post">
                    <div class="mb-4">
                        <div class="input-group">
                            <i class="fas fa-user input-icon"></i>
                            <input type="text" name="name" id="name" class="form-control with-icon" placeholder="Enter full name" required>
                            <label for="name" class="form-label">Full Name</label>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <div class="input-group">
                            <i class="fas fa-envelope input-icon"></i>
                            <input type="email" name="email" id="email" class="form-control with-icon" placeholder="Enter email address" required>
                            <label for="email" class="form-label">Email Address</label>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <div class="input-group">
                            <i class="fas fa-building input-icon"></i>
                            <input type="text" name="company" id="company" class="form-control with-icon" placeholder="Enter company name" required>
                            <label for="company" class="form-label">Company Name</label>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-100 mb-3">
                        <i class="fas fa-save me-2"></i>Save Lead
                    </button>
                </form>

                <hr class="divider">

                <div class="action-buttons">
                    <a href="ViewLeads.jsp" class="btn btn-success">
                        <i class="fas fa-list me-2"></i>View All Leads
                    </a>
                    <a href="marketing.jsp" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Module
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Add smooth focus transitions
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                if (!this.value) {
                    this.parentElement.classList.remove('focused');
                }
            });
        });
    </script>
</body>
</html>