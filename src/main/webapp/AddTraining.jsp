<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Training Session</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px 0;
        }

        .main-container {
            max-width: 600px;
            margin: 0 auto;
        }

        .form-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            border: none;
            backdrop-filter: blur(10px);
        }

        .page-title {
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
            position: relative;
        }

        .page-title::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            margin: 10px auto;
            border-radius: 2px;
        }

        .form-label {
            font-weight: 600;
            color: #34495e;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-control {
            border: 2px solid #e8ecf4;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            background: white;
            transform: translateY(-1px);
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 12px;
            padding: 14px 24px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            background: linear-gradient(135deg, #5a67d8 0%, #6b46c1 100%);
        }

        .btn-success {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            border: none;
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #38a169 0%, #2f855a 100%);
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(72, 187, 120, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #718096 0%, #4a5568 100%);
            border: none;
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #4a5568 0%, #2d3748 100%);
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(113, 128, 150, 0.3);
        }

        .divider {
            margin: 30px 0;
            border: none;
            height: 1px;
            background: linear-gradient(90deg, transparent, #e2e8f0, transparent);
        }

        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .form-floating {
            position: relative;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .icon-label {
            color: #667eea;
            font-size: 18px;
        }

        .mb-3 {
            margin-bottom: 1.5rem !important;
        }

        @media (max-width: 768px) {
            .form-card {
                padding: 25px;
                margin: 15px;
            }
            
            .main-container {
                max-width: 100%;
            }
        }

        /* Animation for form elements */
        .form-card {
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-control, .btn {
            animation: fadeIn 0.8s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="container main-container">
        <div class="card form-card">
            <h2 class="page-title">
                <i class="fas fa-graduation-cap icon-label"></i>
                Add Training/Test Session
            </h2>

            <form action="AddTrainingServlet" method="post">
                <div class="mb-3">
                    <label for="topic" class="form-label">
                        <i class="fas fa-book icon-label"></i>
                        Topic:
                    </label>
                    <input type="text" name="topic" id="topic" class="form-control" required placeholder="Enter training topic">
                </div>
                
                <div class="mb-3">
                    <label for="trainer" class="form-label">
                        <i class="fas fa-user-tie icon-label"></i>
                        Trainer Name:
                    </label>
                    <input type="text" name="trainer" id="trainer" class="form-control" required placeholder="Enter trainer's name">
                </div>
                
                <div class="mb-3">
                    <label for="date" class="form-label">
                        <i class="fas fa-calendar-alt icon-label"></i>
                        Date:
                    </label>
                    <input type="date" name="date" id="date" class="form-control" required>
                </div>
                
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-save me-2"></i>
                    Save Session
                </button>
            </form>

            <hr class="divider">

            <div class="action-buttons">
                <a href="ViewTraining.jsp" class="btn btn-success">
                    <i class="fas fa-eye me-2"></i>
                    View All Sessions
                </a>
                <a href="training.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i>
                    Back to Dashboard
                </a>
            </div>
        </div>
    </div>
</body>
</html>