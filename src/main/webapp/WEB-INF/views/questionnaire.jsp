<%@ page language="java" import="com.NLLDS.model.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Questionnaire</title>
</head>
<body>
  <h1>Questionnaire</h1>
  
  <form id="surveyForm">
    <div>
      <label for="surveyTitle">Title：</label>
      <input type="text" id="surveyTitle" name="surveyTitle" required>
    </div>
    <div>
      <label for="question">Question：</label>
      <textarea id="question" name="question" rows="4" cols="50" required></textarea>
    </div>
    <button type="button" onclick="addQuestion()">Add Question</button>
    <button type="submit">Save</button>
  </form>
  
  <div id="questionList">
    <!-- 这里将显示添加的问题列表 -->
  </div>
  
  <script>
    var questionCount = 0; // 问题计数器
    
    function addQuestion() {
      var question = document.getElementById("question").value;
      
      // 创建问题元素
      var questionElement = document.createElement("div");
      questionElement.innerHTML = "<span>问题 " + (++questionCount) + "：</span>" + question;
      
      // 将问题元素添加到问题列表中
      document.getElementById("questionList").appendChild(questionElement);
      
      // 清空问题输入框
      document.getElementById("question").value = "";
    }
    
    document.getElementById("surveyForm").addEventListener("submit", function(event) {
      event.preventDefault(); // 阻止表单默认提交行为
      
      var surveyTitle = document.getElementById("surveyTitle").value;
      var questions = document.getElementById("questionList").querySelectorAll("div");
      
      // 将问题文本提取为数组
      var questionArray = Array.from(questions).map(function(questionElement) {
        return questionElement.innerText;
      });
      
      // 构造问卷对象
      var surveyData = {
        "surveyTitle": surveyTitle,
        "questions": questionArray
      };
      
      // 发送问卷数据到服务器进行保存
      // 在这里可以使用Ajax或其他方式发送问卷数据到服务器进行保存
      
      // 这里只是一个示例，将问卷数据打印到控制台
      console.log(surveyData);
      
      // 清空表单和问题列表
      event.target.reset();
      document.getElementById("questionList").innerHTML = "";
      questionCount = 0;
    });
  </script>
</body>
</html>