-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: hanashi
-- ------------------------------------------------------
-- Server version	5.7.25-0ubuntu0.18.10.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `banned_users`
--

DROP TABLE IF EXISTS `banned_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banned_users` (
  `Username` varchar(16) NOT NULL,
  `Banned_By` varchar(16) NOT NULL,
  `Comment` varchar(8000) DEFAULT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banned_users`
--

LOCK TABLES `banned_users` WRITE;
/*!40000 ALTER TABLE `banned_users` DISABLE KEYS */;
INSERT INTO `banned_users` VALUES ('test3','test','iyvbyug','2019-04-23 07:36:11');
/*!40000 ALTER TABLE `banned_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edited_posts`
--

DROP TABLE IF EXISTS `edited_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edited_posts` (
  `Post_ID` int(11) NOT NULL,
  `Username` varchar(16) NOT NULL,
  `Comment` varchar(8000) DEFAULT NULL,
  `Timestamp_Modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Post_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edited_posts`
--

LOCK TABLES `edited_posts` WRITE;
/*!40000 ALTER TABLE `edited_posts` DISABLE KEYS */;
INSERT INTO `edited_posts` VALUES (16,'test','Good reason','2019-04-18 19:35:21'),(27,'test','Color wasn\'t good','2019-04-18 19:52:00'),(30,'test','Font too small','2019-04-18 19:51:03');
/*!40000 ALTER TABLE `edited_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edited_threads`
--

DROP TABLE IF EXISTS `edited_threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edited_threads` (
  `Thread_ID` int(11) NOT NULL,
  `Username` varchar(16) NOT NULL,
  `Comment` varchar(8000) DEFAULT NULL,
  `Timestamp_Modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Thread_ID`),
  CONSTRAINT `edited_threads_ibfk_1` FOREIGN KEY (`Thread_ID`) REFERENCES `threads` (`Thread_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edited_threads`
--

LOCK TABLES `edited_threads` WRITE;
/*!40000 ALTER TABLE `edited_threads` DISABLE KEYS */;
INSERT INTO `edited_threads` VALUES (17,'test','xczxc','2019-04-18 08:18:47');
/*!40000 ALTER TABLE `edited_threads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `followers`
--

DROP TABLE IF EXISTS `followers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `followers` (
  `Username1` varchar(16) COLLATE utf8_bin NOT NULL,
  `Username2` varchar(16) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`Username1`,`Username2`),
  KEY `Username2` (`Username2`),
  CONSTRAINT `followers_ibfk_1` FOREIGN KEY (`Username1`) REFERENCES `users` (`Username`),
  CONSTRAINT `followers_ibfk_2` FOREIGN KEY (`Username2`) REFERENCES `users` (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `followers`
--

LOCK TABLES `followers` WRITE;
/*!40000 ALTER TABLE `followers` DISABLE KEYS */;
INSERT INTO `followers` VALUES ('test','Admin'),('test2','Admin'),('test2','test'),('test3','test'),('test','test11'),('test','test2'),('test10','test2'),('test','test3'),('test2','test5'),('test','test8'),('test','test9');
/*!40000 ALTER TABLE `followers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_votes`
--

DROP TABLE IF EXISTS `post_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post_votes` (
  `Post_ID` int(11) NOT NULL,
  `Username` varchar(16) NOT NULL,
  `Vote` int(11) NOT NULL,
  PRIMARY KEY (`Post_ID`,`Username`),
  CONSTRAINT `post_votes_ibfk_1` FOREIGN KEY (`Post_ID`) REFERENCES `posts` (`Post_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_votes`
--

LOCK TABLES `post_votes` WRITE;
/*!40000 ALTER TABLE `post_votes` DISABLE KEYS */;
INSERT INTO `post_votes` VALUES (13,'test',1),(16,'test',1),(16,'test3',1),(17,'test',1),(18,'test3',-1);
/*!40000 ALTER TABLE `post_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `posts` (
  `Post_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Thread_ID` int(11) NOT NULL,
  `Post` longtext NOT NULL,
  `Username` varchar(16) NOT NULL,
  `Votes` int(11) NOT NULL DEFAULT '0',
  `Timestamp_Created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Timestamp_Modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Reply_to` varchar(16) DEFAULT NULL,
  `Visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`Post_ID`),
  KEY `Thread_ID` (`Thread_ID`),
  KEY `posts_username_index` (`Username`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`Thread_ID`) REFERENCES `threads` (`Thread_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (10,11,'<div itemprop=\"text\"><p>A bit decent web application consists of a mix of design patterns. I&#39;ll mention only the most important ones.</p><hr><h2><a href=\"http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller\" rel=\"noreferrer\">Model View Controller pattern</a></h2><p>The core (architectural) design pattern you&#39;d like to use is the <a href=\"http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller\" rel=\"noreferrer\">Model-View-Controller pattern</a>. The <em>Controller</em> is to be represented by a Servlet which (in)directly creates/uses a specific <em>Model</em> and <em>View</em> based on the request. The <em>Model</em> is to be represented by Javabean classes. This is often further dividable in <em>Business Model</em> which contains the actions (behaviour) and <em>Data Model</em> which contains the data (information). The <em>View</em> is to be represented by JSP files which have direct access to the (<em>Data</em>) <em>Model</em> by EL (Expression Language).&nbsp;</p><p>Then, there are variations based on how actions and events are handled. The popular ones are:</p><ul><li><p><strong>Request (action) based MVC</strong>: this is the simplest to implement. The (<em>Business</em>) <em>Model</em> works directly with <code>HttpServletRequest</code> and <code>HttpServletResponse</code> objects. You have to gather, convert and validate the request parameters (mostly) yourself. The <em>View</em> can be represented by plain vanilla HTML/CSS/JS and it does not maintain state across requests. This is how among others <a href=\"https://stackoverflow.com/tags/spring-mvc/info\">Spring MVC</a>, <a href=\"https://stackoverflow.com/tags/struts/info\">Struts</a> and <a href=\"https://stackoverflow.com/tags/stripes/info\">Stripes</a> works.</p></li><li><p><strong>Component based MVC</strong>: this is harder to implement. But you end up with a simpler model and view wherein all the &quot;raw&quot; Servlet API is abstracted completely away. You shouldn&#39;t have the need to gather, convert and validate the request parameters yourself. The <em>Controller</em> does this task and sets the gathered, converted and validated request parameters in the <em>Model</em>. All you need to do is to define action methods which works directly with the model properties. The <em>View</em> is represented by &quot;components&quot; in flavor of JSP taglibs or XML elements which in turn generates HTML/CSS/JS. The state of the <em>View</em> for the subsequent requests is maintained in the session. This is particularly helpful for server-side conversion, validation and value change events. This is how among others <a href=\"https://stackoverflow.com/tags/jsf/info\">JSF</a>, <a href=\"https://stackoverflow.com/tags/wicket/info\">Wicket</a> and <a href=\"https://stackoverflow.com/tags/playframework/info\">Play!</a> works.</p></li></ul><p>As a side note, hobbying around with a homegrown MVC framework is a very nice learning exercise, and I do recommend it as long as you keep it for personal/private purposes. But once you go professional, then it&#39;s strongly recommended to pick an existing framework rather than reinventing your own. Learning an existing and well-developed framework takes in long term less time than developing and maintaining a robust framework yourself.</p><p>In the below detailed explanation I&#39;ll restrict myself to request based MVC since that&#39;s easier to implement.</p><hr><h2><a href=\"http://en.wikipedia.org/wiki/Front_Controller_pattern\" rel=\"noreferrer\">Front Controller pattern</a> (<a href=\"http://en.wikipedia.org/wiki/Mediator_pattern\" rel=\"noreferrer\">Mediator pattern</a>)</h2><p>First, the <em>Controller</em> part should implement the <a href=\"http://en.wikipedia.org/wiki/Front_Controller_pattern\" rel=\"noreferrer\">Front Controller pattern</a> (which is a specialized kind of <a href=\"http://en.wikipedia.org/wiki/Mediator_pattern\" rel=\"noreferrer\">Mediator pattern</a>). It should consist of only a single servlet which provides a centralized entry point of all requests. It should create the <em>Model</em> based on information available by the request, such as the pathinfo or servletpath, the method and/or specific parameters. The <em>Business Model</em> is called <code>Action</code> in the below <a href=\"http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServlet.html\" rel=\"noreferrer\"><code>HttpServlet</code></a> example.</p><pre><code>protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {\r\n    try {\r\n        Action action = ActionFactory.getAction(request);\r\n        String view = action.execute(request, response);\r\n\r\n        if (view.equals(request.getPathInfo().substring(1)) {\r\n            request.getRequestDispatcher(&quot;/WEB-INF/&quot; + view + &quot;.jsp&quot;).forward(request, response);\r\n        }\r\n        else {\r\n            response.sendRedirect(view); // We&#39;d like to fire redirect in case of a view change as result of the action (PRG pattern).\r\n        }\r\n    }\r\n    catch (Exception e) {\r\n        throw new ServletException(&quot;Executing action failed.&quot;, e);\r\n    }\r\n}</code></pre><p>Executing the action should return some identifier to locate the view. Simplest would be to use it as filename of the JSP. Map this servlet on a specific <code>url-pattern</code> in <code>web.xml</code>, e.g. <code>/pages/*</code>, <code>*.do</code> or even just <code>*.html</code>.&nbsp;</p><p>In case of prefix-patterns as for example <code>/pages/*</code> you could then invoke URL&#39;s like <a href=\"http://example.com/pages/register\" rel=\"noreferrer\">http://example.com/pages/register</a>, <a href=\"http://example.com/pages/login\" rel=\"noreferrer\">http://example.com/pages/login</a>, etc and provide <code>/WEB-INF/register.jsp</code>, <code>/WEB-INF/login.jsp</code> with the appropriate GET and POST actions. The parts <code>register</code>, <code>login</code>, etc are then available by <a href=\"http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getPathInfo--\" rel=\"noreferrer\"><code>request.getPathInfo()</code></a> as in above example.&nbsp;</p><p>When you&#39;re using suffix-patterns like <code>*.do</code>, <code>*.html</code>, etc, then you could then invoke URL&#39;s like <a href=\"http://example.com/register.do\" rel=\"noreferrer\">http://example.com/register.do</a>, <a href=\"http://example.com/login.do\" rel=\"noreferrer\">http://example.com/login.do</a>, etc and you should change the code examples in this answer (also the <code>ActionFactory</code>) to extract the <code>register</code> and <code>login</code> parts by <a href=\"http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getServletPath--\" rel=\"noreferrer\"><code>request.getServletPath()</code></a> instead.</p><hr><h2><a href=\"http://en.wikipedia.org/wiki/Strategy_pattern\" rel=\"noreferrer\">Strategy pattern</a></h2><p>The <code>Action</code> should follow the <a href=\"http://en.wikipedia.org/wiki/Strategy_pattern\" rel=\"noreferrer\">Strategy pattern</a>. It needs to be defined as an abstract/interface type which should do the work based on the <em>passed-in</em> arguments of the abstract method (this is the difference with the <a href=\"http://en.wikipedia.org/wiki/Command_pattern\" rel=\"noreferrer\">Command pattern</a>, wherein the abstract/interface type should do the work based on the arguments which are been passed-in during the <em>creation</em> of the implementation).</p><pre><code>public interface Action {\r\n    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception;\r\n}</code></pre><p>You may want to make the <code>Exception</code> more specific with a custom exception like <code>ActionException</code>. It&#39;s just a basic kickoff example, the rest is all up to you.</p><p>Here&#39;s an example of a <code>LoginAction</code> which (as its name says) logs in the user. The <code>User</code> itself is in turn a <em>Data Model</em>. The <em>View</em> is aware of the presence of the <code>User</code>.</p><pre><code>public class LoginAction implements Action {\r\n\r\n    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {\r\n        String username = request.getParameter(&quot;username&quot;);\r\n        String password = request.getParameter(&quot;password&quot;);\r\n        User user = userDAO.find(username, password);\r\n\r\n        if (user != null) {\r\n            request.getSession().setAttribute(&quot;user&quot;, user); // Login user.\r\n            return &quot;home&quot;; // Redirect to home page.\r\n        }\r\n        else {\r\n            request.setAttribute(&quot;error&quot;, &quot;Unknown username/password. Please retry.&quot;); // Store error message in request scope.\r\n            return &quot;login&quot;; // Go back to redisplay login form with error.\r\n        }\r\n    }\r\n\r\n}</code></pre><hr><h2><a href=\"http://en.wikipedia.org/wiki/Abstract_factory_pattern\" rel=\"noreferrer\">Factory method pattern</a></h2><p>The <code>ActionFactory</code> should follow the <a href=\"http://en.wikipedia.org/wiki/Factory_method\" rel=\"noreferrer\">Factory method pattern</a>. Basically, it should provide a creational method which returns a concrete implementation of an abstract/interface type. In this case, it should return an implementation of the <code>Action</code> interface based on the information provided by the request. For example, the <a href=\"http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getMethod--\" rel=\"noreferrer\">method</a> and <a href=\"http://docs.oracle.com/javaee/7/api/javax/servlet/http/HttpServletRequest.html#getPathInfo--\" rel=\"noreferrer\">pathinfo</a> (the pathinfo is the part after the context and servlet path in the request URL, excluding the query string).</p><pre><code>public static Action getAction(HttpServletRequest request) {\r\n    return actions.get(request.getMethod() + request.getPathInfo());\r\n}</code></pre><p>The <code>actions</code> in turn should be some static/applicationwide <code>Map</code> which holds all known actions. It&#39;s up to you how to fill this map. Hardcoding:</p><pre><code>actions.put(&quot;POST/register&quot;, new RegisterAction());\r\nactions.put(&quot;POST/login&quot;, new LoginAction());\r\nactions.put(&quot;GET/logout&quot;, new LogoutAction());\r\n// ...</code></pre><p>Or configurable based on a properties/XML configuration file in the classpath: (pseudo)</p><pre><code>for (Entry entry : configuration) {\r\n    actions.put(entry.getKey(), Class.forName(entry.getValue()).newInstance());\r\n}</code></pre><p>Or dynamically based on a scan in the classpath for classes implementing a certain interface and/or annotation: (pseudo)</p><pre><code>for (ClassFile classFile : classpath) {\r\n    if (classFile.isInstanceOf(Action.class)) {\r\n       actions.put(classFile.getAnnotation(&quot;mapping&quot;), classFile.newInstance());\r\n    }\r\n}</code></pre><p>Keep in mind to create a &quot;do nothing&quot; <code>Action</code> for the case there&#39;s no mapping. Let it for example return directly the <code>request.getPathInfo().substring(1)</code> then.</p><hr><h3>Other patterns</h3><p>Those were the important patterns so far.&nbsp;</p><p>To get a step further, you could use the <a href=\"http://en.wikipedia.org/wiki/Facade_pattern\" rel=\"noreferrer\">Facade pattern</a> to create a <code>Context</code> class which in turn wraps the request and response objects and offers several convenience methods delegating to the request and response objects and pass that as argument into the <code>Action#execute()</code> method instead. This adds an extra abstract layer to hide the raw Servlet API away. You should then basically end up with <strong>zero</strong> <code>import javax.servlet.*</code> declarations in every <code>Action</code> implementation. In JSF terms, this is what the <a href=\"http://docs.oracle.com/javaee/7/api/javax/faces/context/FacesContext.html\" rel=\"noreferrer\"><code>FacesContext</code></a> and <a href=\"http://docs.oracle.com/javaee/7/api/javax/faces/context/ExternalContext.html\" rel=\"noreferrer\"><code>ExternalContext</code></a> classes are doing. You can find a concrete example in <a href=\"https://stackoverflow.com/questions/4764285/retrieving-web-session-from-a-pojo-outside-the-web-container/4764894#4764894\">this answer</a>.</p><p>Then there&#39;s the <a href=\"http://en.wikipedia.org/wiki/State_pattern\" rel=\"noreferrer\">State pattern</a> for the case that you&#39;d like to add an extra abstraction layer to split the tasks of gathering the request parameters, converting them, validating them, updating the model values and execute the actions. In JSF terms, this is what the <a href=\"http://download.oracle.com/javaee/7/api/javax/faces/lifecycle/Lifecycle.html\" rel=\"noreferrer\"><code>LifeCycle</code></a> is doing.</p><p>Then there&#39;s the <a href=\"http://en.wikipedia.org/wiki/Composite_pattern\" rel=\"noreferrer\">Composite pattern</a> for the case that you&#39;d like to create a component based view which can be attached with the model and whose behaviour depends on the state of the request based lifecycle. In JSF terms, this is what the <a href=\"http://docs.oracle.com/javaee/7/api/javax/faces/component/UIComponent.html\" rel=\"noreferrer\"><code>UIComponent</code></a> represent.&nbsp;</p><p>This way you can evolve bit by bit towards a component based framework.</p><hr><h3>See also:</h3><ul><li><a href=\"https://stackoverflow.com/questions/1673841\">Examples of GoF Design Patterns in Java&#39;s core libraries</a></li><li><a href=\"https://stackoverflow.com/questions/4801891\">Difference between Request MVC and Component MVC</a></li><li><a href=\"https://stackoverflow.com/questions/5003142\">Show JDBC ResultSet in HTML in JSP page using MVC and DAO pattern</a></li><li><a href=\"https://stackoverflow.com/questions/5104094\">What components are MVC in JSF MVC framework?</a></li><li><a href=\"https://stackoverflow.com/questions/30639785\">JSF Controller, Service and DAO</a></li></ul></div>','test8',0,'2019-03-29 15:21:45','2019-04-08 19:49:39',NULL,1),(11,12,'<div itemprop=\"text\"><blockquote><h2>requestDispatcher - forward() method</h2>&nbsp; &nbsp;<ol><li><p>When we use the <code>forward</code> method, the request is transferred to another resource within the same server for further processing.</p></li><li>&nbsp;</li><li><p>In the case of <code>forward</code>, the web container handles all processing internally and the client or browser is not involved.</p></li><li>&nbsp;</li><li><p>When <code>forward</code> is called on the <code>requestDispatcher</code>object, we pass the request and response objects, so our old request object is present on the new resource which is going to process our request.</p></li><li>&nbsp;</li><li><p>Visually, we are not able to see the forwarded address, it is transparent.</p></li><li>&nbsp;</li><li><p>Using the <code>forward()</code> method is faster than <code>sendRedirect</code>.</p></li><li>&nbsp;</li><li><p>When we redirect using forward, and we want to use the same data in a new resource, we can use <code>request.setAttribute()</code> as we have a request object available.</p></li></ol>&nbsp; &nbsp;<h2>SendRedirect</h2>&nbsp; &nbsp;<ol><li><p>In case of <code>sendRedirect</code>, the request is transferred to another resource, to a different domain, or to a &nbsp;different server for further processing.</p></li><li>&nbsp;</li><li><p>When you use <code>sendRedirect</code>, the container transfers the request to the client or browser, so the URL given inside the <code>sendRedirect</code> method is visible as a new request to the client.</p></li><li>&nbsp;</li><li><p>In case of <code>sendRedirect</code> call, the old request and response objects are lost because it&rsquo;s treated as new request by the browser.</p></li><li>&nbsp;</li><li><p>In the address bar, we are able to see the new redirected address. It&rsquo;s not transparent.</p></li><li>&nbsp;</li><li><p><code>sendRedirect</code> is slower because one extra round trip is required, because a completely new request is created and the old request object is lost. Two browser request are required.</p></li><li>&nbsp;</li><li><p>But in <code>sendRedirect</code>, if we want to use we have to store the data in session or pass along with the URL.</p></li></ol>&nbsp; &nbsp;<h2>Which one is good?</h2>&nbsp; &nbsp;<p>Its depends upon the scenario for which method is more useful.</p>&nbsp; &nbsp;<p>If you want control is transfer to new server or context, and it is treated as completely new task, then we go for <code>sendRedirect</code>. &nbsp;Generally, a forward should be used if the operation can be safely repeated upon a browser reload of the web page and will not affect the result.</p></blockquote><p><a href=\"http://javarevisited.blogspot.in/2011/09/sendredirect-forward-jsp-servlet.html\" rel=\"nofollow noreferrer\">Source</a></p></div>','test8',0,'2019-03-29 15:41:03','2019-03-29 15:41:03',NULL,1),(12,12,'<div itemprop=\"text\"><p>In the web development world, the term &quot;redirect&quot; is &nbsp;the act of sending the client an empty HTTP response with just a <code>Location</code> header containing the new URL to which the client has to send a brand new GET request. So basically:</p><ul><li>Client sends a HTTP request to <code>some.jsp</code>.</li><li>Server sends a HTTP response back with <code>Location: other.jsp</code> header</li><li>Client sends a HTTP request to <code>other.jsp</code> (this get reflected in browser address bar!)</li><li>Server sends a HTTP response back with content of <code>other.jsp</code>.</li></ul><p>You can track it with the web browser&#39;s builtin/addon developer toolset. Press F12 in Chrome/IE9/Firebug and check the &quot;Network&quot; section to see it.</p><p>Exactly the above is achieved by <code>sendRedirect(&quot;other.jsp&quot;)</code>. The <code>RequestDispatcher#forward()</code> doesn&#39;t send a redirect. Instead, it uses the content of the target page as HTTP response.</p><ul><li>Client sends a HTTP request to <code>some.jsp</code>.</li><li>Server sends a HTTP response back with content of <code>other.jsp</code>.</li></ul><p>However, as the original HTTP request was to <code>some.jsp</code>, the URL in browser address bar remains unchanged.&nbsp;</p><hr><p>The <code>RequestDispatcher</code> is extremely useful in the MVC paradigm and/or when you want to hide JSP&#39;s from direct access. You can put JSP&#39;s in the <code>/WEB-INF</code> folder and use a <code>Servlet</code> which controls, preprocesses and postprocesses the requests. The JSPs in the <code>/WEB-INF</code> folder are not directly accessible by URL, but the <code>Servlet</code> can access them using <code>RequestDispatcher#forward()</code>.&nbsp;</p><p>You can for example have a JSP file in <code>/WEB-INF/login.jsp</code> and a <code>LoginServlet</code> which is mapped on an <code>url-pattern</code> of <code>/login</code>. When you invoke <code>http://example.com/context/login</code>, then the servlet&#39;s <code>doGet()</code> will be invoked. You can do any <em>pre</em>processing stuff in there and finally <strong>forward</strong> the request like:</p><pre><code>request.getRequestDispatcher(&quot;/WEB-INF/login.jsp&quot;).forward(request, response);</code></pre><p>When you submit a form, you normally want to use <code>POST</code>:</p><pre><code>&lt;form action=&quot;login&quot; method=&quot;post&quot;&gt;</code></pre><p>This way the servlet&#39;s <code>doPost()</code> will be invoked and you can do any <em>post</em>processing stuff in there (e.g. validation, business logic, login the user, etc).</p><p>If there are any errors, then you normally want to <strong>forward</strong> the request back to the same page and display the errors there next to the input fields and so on. You can use the <code>RequestDispatcher</code> for this.</p><p>If a <code>POST</code> is successful, you normally want to <strong>redirect</strong> the request, so that the request won&#39;t be resubmitted when the user refreshes the request (e.g. pressing F5 or navigating back in history).&nbsp;</p><pre><code>User user = userDAO.find(username, password);\r\nif (user != null) {\r\n    request.getSession().setAttribute(&quot;user&quot;, user); // Login user.\r\n    response.sendRedirect(&quot;home&quot;); // Redirects to http://example.com/context/home after succesful login.\r\n} else {\r\n    request.setAttribute(&quot;error&quot;, &quot;Unknown login, please try again.&quot;); // Set error.\r\n    request.getRequestDispatcher(&quot;/WEB-INF/login.jsp&quot;).forward(request, response); // Forward to same page so that you can display error.\r\n}</code></pre><p>A <strong>redirect</strong> thus instructs the client to fire a new <code>GET</code> request on the given URL. Refreshing the request would then only refresh the redirected request and not the initial request. This will avoid &quot;double submits&quot; and confusion and bad user experiences. This is also called the <a href=\"http://en.wikipedia.org/wiki/Post/Redirect/Get\" rel=\"nofollow noreferrer\"><code>POST-Redirect-GET</code> pattern</a>.</p></div>','test',0,'2019-03-29 15:45:29','2019-03-29 15:45:29',NULL,1),(13,13,'<div itemprop=\"text\"><p>The <code>java.sql.Date()</code> strips time portion of your date due to SQL convention. You can check <a href=\"http://www.contrib.andrew.cmu.edu/~shadow/sql/sql1992.txt\" rel=\"nofollow\">SQL-92 standard</a>.</p><pre><code>Timestamp updatedAt = new Timestamp(Calendar.getInstance().getTimeInMillis());\r\nstmt.setTimestamp(2, updatedAt);</code></pre></div>','test5',1,'2019-03-29 18:46:58','2019-03-29 18:46:58',NULL,1),(14,14,'<div itemprop=\"text\"><p>Considering the whole issue Javascript (client side) + API (server side) could complicate diagnosing the issue, so my suggestion to get a more specific answer would be to isolate the issue first.</p><p><strong>Answering your general question, Reasons why?:</strong> It could be a lot of things but the remarkable ones are:</p><ol><li><strong>Handshake:</strong> the first interaction between your page and the server makes the remote server to authenticate you and validate your session. Later calls wont go through that process.</li><li><strong>Server first execution:</strong> (less probable if you are using public APIs) if you are using a remote server with Java for example, that you are restarting, the first time you call a service it will load the instances, but for future calls those instances are already created hence they respond faster.&nbsp;</li><li><strong>Network:</strong> (I don&#39;t think so... but...) trace your HTTP request to see how many jumps it has and how much is taking for them to be resolved.&nbsp;</li></ol><p><strong>How to Diagnose (isolation):</strong> Measure the time each step takes, it could be a simple print of your current time. I would break it the in the following steps:</p><ol><li>Preparing the call to the API.</li><li>Calling the API.</li><li>Getting the data.</li><li>Manipulate the received data on the client side.&nbsp;</li></ol><p><em>NOTE: steps 2 and 3 could go together.</em>&nbsp;</p><p><strong>How to mitigate this from happening</strong> (it doesn&#39;t solve the issue, but mitigates it):</p><ol><li><strong>Handshake:</strong> if the issue is related with authentication/authorization I recommend you to do an empty pre-fetch (without requesting any data) to deal with the handshake. Then you do a data fetch when you need it without that overhead.</li><li><strong>Server first execution:</strong> you don&#39;t have too much to do here unless you own the server also. In this case I recommend also a pre-fetch but calling the entire service to initialize the server objects.&nbsp;</li><li><strong>Javascript API:</strong> if the problem is dealing with the data on your client side then review how to optimize your Javascript code.&nbsp;</li></ol></div>','test',0,'2019-04-06 07:42:43','2019-04-06 07:42:43',NULL,1),(15,15,'<div itemprop=\"text\"><p>Your example can be more simply stated by not involving the future:</p><blockquote><p>Can god create something that is so &nbsp;heavy that he can not move it?</p></blockquote><p>The answer of course is &quot;Yes&quot;. But then, you say, he would not be omnipotent as he can not move it. But that&#39;s wrong. He can. Because he is omnipotent. Hence:</p><blockquote><p>An omnipotent being is able to move &nbsp;that which he is unable to move.</p></blockquote><p>If you want to call this consistent or not is up to you. It is inconsistent as seen from a logical framework. But it is consistent with the standpoint that an omnipotent being by definition can do <em>anything</em>, <strong>including breaking the laws of logic</strong>.</p><p>God is generally claimed to have created everything, including logic, so he is not susceptible to them, or any form of reason. That also per definition makes God unknowable, unreachable and unscientific. He can not even be discussed in any form of meaningful way with human words, rendering your question and my answer equally meaningless.</p></div>','test',0,'2019-04-06 08:27:42','2019-04-06 08:31:19',NULL,1),(16,16,'<p><span style=\"font-size: 24px;\"><span style=\"color: rgb(184, 49, 47);\">Valar</span><span style=\"color: rgb(41, 105, 176);\"> Morghulis</span></span></p>','test2',2,'2019-04-08 19:56:49','2019-04-08 19:56:49',NULL,1),(17,16,'<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed gravida mattis eros vitae ultrices. Suspendisse iaculis nibh id felis semper, in eleifend erat interdum. Sed id leo libero. Vestibulum porta dui et maximus rhoncus. Proin finibus cursus sem at consectetur. Pellentesque lobortis ultrices ipsum, ornare faucibus sem efficitur vitae. Proin quis nulla laoreet, luctus sapien et, vestibulum lorem.</p><p>Sed molestie, eros sed euismod malesuada, metus turpis sodales mauris, pulvinar placerat nisl sem ac nulla. Aliquam blandit, urna non tincidunt eleifend, enim urna feugiat ligula, et eleifend libero justo in urna. Nam tristique, risus nec finibus mollis, turpis nisl lacinia tortor, ut sagittis turpis augue et ligula. Fusce blandit pharetra dolor, nec blandit mauris varius sit amet. Suspendisse lacinia, nunc ut viverra maximus, dui lorem pulvinar ipsum, vel scelerisque nunc lectus nec erat. Mauris eu erat arcu. In suscipit enim enim, eget vestibulum ligula placerat id. Donec faucibus feugiat enim eu blandit. Cras quis magna vulputate, pretium ante a, lacinia libero. Fusce posuere in massa id faucibus. Sed pharetra suscipit accumsan. Morbi vel sodales est, non mollis sem. Sed suscipit fringilla consectetur.</p><p>Donec nec magna eget dolor commodo vehicula id eu nunc. Aenean pellentesque quam eu purus volutpat, vitae mollis nulla consequat. Morbi ut magna justo. Donec elementum euismod tempor. Integer venenatis ipsum turpis, ac tempor augue bibendum ac. Fusce nec posuere dolor. Aliquam tellus nibh, blandit porttitor elit sit amet, pulvinar auctor purus. Praesent facilisis feugiat mauris, quis consectetur lacus maximus non.</p><p><br></p>','test2',1,'2019-04-08 19:57:52','2019-04-08 19:58:57',NULL,1),(18,16,'<p><span style=\"font-size: 24px; color: rgb(41, 105, 176);\">Lorem ipsum dolor sit amet. </span></p>','test2',-1,'2019-04-08 19:58:25','2019-04-08 19:58:25',NULL,1),(19,16,'<p>Suspendisse potenti. Morbi venenatis lorem quis orci tincidunt, vel lobortis magna facilisis. Nullam eget vulputate tortor. Donec eu pellentesque sem. Aliquam erat volutpat. Nullam a ultrices mi, ut dapibus mauris. Quisque diam augue, interdum id tellus vel, malesuada dignissim ipsum. Proin fringilla eu sem a condimentum. Donec sed gravida diam. Ut bibendum ultricies finibus. Suspendisse ultrices tincidunt odio accumsan euismod. Donec in libero quis metus tincidunt rutrum vitae sit amet velit. Ut interdum vitae augue et vehicula. Interdum et malesuada fames ac ante ipsum primis in faucibus.</p><p>Donec nec scelerisque turpis, pulvinar euismod diam. Nunc semper egestas orci, non dictum tortor bibendum vulputate. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam id justo ut est posuere efficitur in eget lacus. Quisque quis elit id erat aliquam interdum. In euismod tellus quis dignissim feugiat. Phasellus nec porta enim. Ut congue, dui non feugiat egestas, arcu enim ornare ipsum, quis dapibus elit lacus eu augue. Pellentesque fringilla sapien sit amet dolor vulputate, in dapibus libero aliquam. Cras mauris arcu, porta id lectus sit amet, mollis dictum felis. Nam odio leo, sagittis at pellentesque eget, consequat id nisi. Ut ornare bibendum elit, vel tristique dolor tempor eu. Suspendisse potenti. Morbi rhoncus, eros ut elementum aliquam, elit velit tincidunt justo, a varius magna nisl lobortis elit.&nbsp;</p>','test3',0,'2019-04-08 20:00:01','2019-04-08 20:00:01',NULL,1),(20,16,'<p><span style=\"font-size: 24px;\"><span class=\"fr-class-highlighted\">Some highlighted text!!</span></span></p>','ina',0,'2019-04-09 17:38:06','2019-04-09 17:38:06',NULL,1),(22,16,'<span class=\"fr-class-code\">Some coded text</span>','ina',0,'2019-04-09 18:14:06','2019-04-09 18:14:06',NULL,1),(23,16,'<p><span class=\"fr-class-code\">Another Code text but big one.&nbsp;</span></p><p><span class=\"fr-class-code\">Donec nec scelerisque turpis, pulvinar euismod diam. Nunc semper egestas orci, non dictum tortor bibendum vulputate. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam id justo ut est posuere efficitur in eget lacus. Quisque quis elit id erat aliquam interdum. In euismod tellus quis dignissim feugiat. Phasellus nec porta enim. Ut congue, dui non feugiat egestas, arcu enim ornare ipsum, quis dapibus elit lacus eu augue. Pellentesque fringilla sapien sit amet dolor vulputate, in dapibus libero aliquam. Cras mauris arcu, porta id lectus sit amet, mollis dictum felis. Nam odio leo, sagittis at pellentesque eget, consequat id nisi. Ut ornare bibendum elit, vel tristique dolor tempor eu. Suspendisse potenti. Morbi rhoncus, eros ut elementum aliquam, elit velit tincidunt justo, a varius magna nisl lobortis elit. </span></p>','ina',0,'2019-04-09 18:30:18','2019-04-09 18:30:18',NULL,1),(24,16,'<p>Some reply which doesn&#39;t really matter.</p>','test11',0,'2019-04-10 17:33:10','2019-04-10 17:33:10',NULL,0),(25,16,'<p><span style=\"font-size: 24px; color: rgb(65, 168, 95);\">Haha, Good one. :P</span></p>','test11',0,'2019-04-10 17:35:45','2019-04-10 18:09:12','16',1),(26,16,'<p><span style=\"font-size: 24px; color: rgb(184, 49, 47);\">What&#39;s going on?</span></p>','test11',0,'2019-04-10 17:56:34','2019-04-10 17:56:34','16',1),(27,16,'<p><span style=\"color: rgb(184, 49, 47); font-size: 24px;\">You know nothing!</span></p>','test3',0,'2019-04-10 18:04:11','2019-04-10 18:04:52','16',1),(28,16,'ina nice code ','test',0,'2019-04-10 18:36:04','2019-04-18 18:52:56','22',1),(29,16,'<p><span class=\"reply-to-username fr-deletable\" contenteditable=\"false\">@test</span><span contenteditable=\"true\"> </span>Thanks!</p>','ina',0,'2019-04-10 18:38:51','2019-04-10 18:38:51','22',1),(30,16,'<p><span class=\"reply-to-username fr-deletable\" contenteditable=\"false\">@test2</span><span contenteditable=\"true\">&nbsp;</span><span style=\"color: rgb(85, 57, 130); font-size: 18px;\">Yohoho!</span></p>','test',0,'2019-04-10 18:47:20','2019-04-10 18:47:20','16',1),(31,10,'<p>My answer</p>','test',0,'2019-04-16 06:08:30','2019-04-16 06:08:30',NULL,1),(32,17,'<p><span style=\"color: rgb(209, 72, 65); font-size: 18px;\">You can&#39;t!!</span> and Vegeta will probably get stronger than you.</p>','whis',0,'2019-04-17 06:38:55','2019-04-17 06:38:55',NULL,1),(33,17,'<p><span class=\"reply-to-username fr-deletable\" contenteditable=\"false\">@whis</span><span contenteditable=\"true\">&nbsp;</span>Shut up you daddy&#39;s angel</p>','Goku',0,'2019-04-17 06:40:27','2019-04-17 06:40:27','32',1);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `processed_posts`
--

DROP TABLE IF EXISTS `processed_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `processed_posts` (
  `Thread_ID` int(11) NOT NULL,
  `Post_ID` int(11) NOT NULL,
  `Post` longtext NOT NULL,
  `Username` varchar(16) NOT NULL,
  PRIMARY KEY (`Post_ID`),
  FULLTEXT KEY `Post` (`Post`,`Username`),
  FULLTEXT KEY `Post_2` (`Post`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `processed_posts`
--

LOCK TABLES `processed_posts` WRITE;
/*!40000 ALTER TABLE `processed_posts` DISABLE KEYS */;
INSERT INTO `processed_posts` VALUES (11,10,'bit decent web applic consist mix design pattern ill mention import on model view control pattern the core architectur design pattern youd modelviewcontrol pattern the control repres servlet indirectli createsus specif model view base request the model repres javabean class thi divid busi model action behaviour data model data inform the view repres jsp file direct access data model el express languag then variat base action event handl the popular ar request action base mvc simplest implement the busi model work directli httpservletrequest httpservletrespons object you gather convert valid request paramet mostli yourself the view repres plain vanilla htmlcssj maintain state request thi spring mvc strut stripe work compon base mvc harder implement but end simpler model view raw servlet api abstract complet awai you shouldnt gather convert valid request paramet yourself the control task set gather convert valid request paramet model all defin action method work directli model properti the view repres compon flavor jsp taglib xml element turn gener htmlcssj the state view subsequ request maintain session thi help serversid convers valid chang event thi jsf wicket plai work as side note hobbi homegrown mvc framework nice learn exercis recommend long personalpriv purpos but profession it strongli recommend pick exist framework reinvent own learn exist welldevelop framework take long term time develop maintain robust framework yourself in detail explan ill restrict request base mvc that easier implement front control pattern mediat pattern first control part implement front control pattern which special kind mediat pattern it consist singl servlet central entri point request it creat model base inform request pathinfo servletpath method andor specif paramet the busi model call action httpservlet exampl protect void servicehttpservletrequest request httpservletrespons respons throw servletexcept ioexcept action action actionfactorygetactionrequest string view actionexecuterequest respons viewequalsrequestgetpathinfosubstr requestgetrequestdispatcherwebinf view jspforwardrequest respons responsesendredirectview  wed fire redirect case view chang result action prg pattern catch except e throw servletexceptionexecut action fail e execut action return identifi locat view simplest filenam jsp map servlet specif urlpattern webxml eg page do html in case prefixpattern page invok url httpexamplecompagesregist httpexamplecompageslogin provid webinfregisterjsp webinfloginjsp get post action the part regist login requestgetpathinfo exampl when your suffixpattern do html etc invok url httpexamplecomregisterdo httpexamplecomlogindo chang code exampl answer also actionfactori extract regist login part requestgetservletpath instead strategi pattern the action follow strategi pattern it defin abstractinterfac type work base passedin argument abstract method thi differ command pattern abstractinterfac type work base argument passedin creation implement public interfac action public string executehttpservletrequest request httpservletrespons respons throw except you make except specif custom except actionexcept it basic kickoff exampl rest you here loginact as sai log user the user turn data model the view awar presenc user public class loginact implement action public string executehttpservletrequest request httpservletrespons respons throw except string usernam requestgetparameterusernam string password requestgetparameterpassword user user userdaofindusernam password user  null requestgetsessionsetattributeus user  login user return home  redirect home page requestsetattributeerror unknown usernamepassword pleas retri  store error messag request scope return login  go back redisplai login form error factori method pattern the actionfactori follow factori method pattern basic provid creation method return concret implement abstractinterfac type in case return implement action interfac base inform provid request for exampl method pathinfo the pathinfo part context servlet path request url exclud queri string public static action getactionhttpservletrequest request return actionsgetrequestgetmethod requestgetpathinfo the action turn staticapplicationwid map hold action it fill map hardcod actionsputpostregist registeract actionsputpostlogin loginact actionsputgetlogout logoutact   or configur base propertiesxml configur file classpath pseudo entri entri configur actionsputentrygetkei classfornameentrygetvaluenewinst or dynam base scan classpath class implement interfac andor annot pseudo classfil classfil classpath classfileisinstanceofactionclass actionsputclassfilegetannotationmap classfilenewinst keep mind creat do noth action case there map let return directli requestgetpathinfosubstr then other pattern those import pattern far to step further facad pattern creat context class turn wrap request respons object offer conveni method deleg request respons object pass argument actionexecut method instead thi add extra abstract layer hide raw servlet api awai you basic end import javaxservlet declar action implement in jsf term facescontext externalcontext class do you find concret answer then there state pattern case youd add extra abstract layer split task gather request paramet convert them valid them updat model valu execut action in jsf term lifecycl do then there composit pattern case youd creat compon base view attach model behaviour depend state request base lifecycl in jsf term uicompon repres thi evolv bit bit compon base framework see also exampl gof design pattern java core librari differ request mvc compon mvc show jdbc resultset html jsp page mvc dao pattern what compon mvc jsf mvc framework jsf control servic dao ','test8'),(12,11,'requestdispatch forward method when forward method request transfer resourc server process in case forward web contain handl process intern client browser involv when forward call requestdispatcherobject pass request respons object request object present resourc process request visual forward address transpar us forward method faster sendredirect when redirect forward data resourc requestsetattribut request object avail sendredirect in case sendredirect request transfer resourc domain server process when sendredirect contain transfer request client browser url insid sendredirect method visibl request client in case sendredirect call request respons object lost it treat request browser in address bar redirect address it transpar sendredirect slower extra round trip requir complet request creat request object lost two browser request requir but sendredirect store data session pass url which good it depend scenario method us if control transfer server context treat complet task sendredirect gener forward oper safe repeat browser reload web page affect result sourc ','test8'),(12,12,'in web develop world term redirect act send client empti http respons locat header url client send brand get request so basic client send http request somejsp server send http respons back locat otherjsp header client send http request otherjsp thi reflect browser address bar server send http respons back content otherjsp you track web browser builtinaddon develop toolset press f chromeiefirebug check network section it exactli achiev sendredirectotherjsp the requestdispatcherforward doesnt send redirect instead content target page http respons client send http request somejsp server send http respons back content otherjsp howev origin http request somejsp url browser address bar remain unchang the requestdispatch extrem mvc paradigm andor hide jsp direct access you put jsp webinf folder servlet control preprocess postprocess request the jsp webinf folder directli access url servlet access requestdispatcherforward you jsp file webinfloginjsp loginservlet map urlpattern login when invok httpexamplecomcontextlogin servlet doget invok you preprocess stuff final forward request like requestgetrequestdispatcherwebinfloginjspforwardrequest respons when submit form post form actionlogin methodpost thi servlet dopost invok postprocess stuff eg valid busi logic login user etc if error forward request back page displai error input field on you requestdispatch thi if post success redirect request request wont resubmit user refresh request eg press f navig back histori user user userdaofindusernam password user  null requestgetsessionsetattributeus user  login user responsesendredirecthom  redirect httpexamplecomcontexthom succes login requestsetattributeerror unknown login again  set error requestgetrequestdispatcherwebinfloginjspforwardrequest respons  forward page displai error redirect instruct client fire get request url refresh request refresh redirect request initi request thi avoid doubl submit confus bad user experi thi call postredirectget pattern ','test'),(13,13,'the javasqld strip time portion date due sql convent you check sql standard timestamp updatedat timestampcalendargetinstancegettimeinmilli stmtsettimestamp updatedat ','test5'),(14,14,'consid issu javascript client side api server side complic diagnos issu suggest specif answer isol issu first answer gener question reason why it lot thing remark ar handshak interact page server make remot server authent valid session later call process server execut less probabl public api remot server java exampl restart time call servic load instanc futur call instanc creat respond faster network i dont so but trace http request jump take resolv how diagnos isol measur time step take simpl print current time break step prepar call api call api get data manipul receiv data client side note step togeth how mitig happen it doesnt solv issu mitig it handshak issu relat authenticationauthor recommend empti prefetch without request data deal handshak then data fetch overhead server execut dont server also in case recommend prefetch call entir servic initi server object javascript api problem deal data client side review optim javascript code ','test'),(15,15,'your simpli state involv futur can god creat heavi move it the answer ye but then sai omnipot move it but that wrong he can becaus omnipot henc an omnipot move unabl move if call consist you it inconsist logic framework but consist standpoint omnipot definit anyth includ break law logic god gener claim creat everyth includ logic suscept them form reason that definit make god unknow unreach unscientif he discuss form meaning human word render question answer equal meaningless ','test'),(16,16,'valar morghuli ','test2'),(16,17,'lorem ipsum dolor sit amet consectetur adipisc elit sed gravida matti ero vita ultric suspendiss iaculi nibh feli semper eleifend erat interdum sed leo libero vestibulum porta dui maximu rhoncu proin finibu cursu sem consectetur pellentesqu loborti ultric ipsum ornar faucibu sem efficitur vita proin qui nulla laoreet luctu sapien et vestibulum lorem sed molesti ero sed euismod malesuada metu turpi sodal mauri pulvinar placerat nisl sem ac nulla aliquam blandit urna tincidunt eleifend enim urna feugiat ligula eleifend libero justo urna nam tristiqu risu nec finibu molli turpi nisl lacinia tortor ut sagitti turpi augu ligula fusc blandit pharetra dolor nec blandit mauri variu sit amet suspendiss lacinia nunc ut viverra maximu dui lorem pulvinar ipsum vel scelerisqu nunc lectu nec erat mauri eu erat arcu in suscipit enim enim eget vestibulum ligula placerat id donec faucibu feugiat enim eu blandit cra qui magna vulput pretium ant a lacinia libero fusc posuer massa faucibu sed pharetra suscipit accumsan morbi vel sodal est molli sem sed suscipit fringilla consectetur donec nec magna eget dolor commodo vehicula eu nunc aenean pellentesqu quam eu puru volutpat vita molli nulla consequat morbi ut magna justo donec elementum euismod tempor integ venenati ipsum turpi ac tempor augu bibendum ac fusc nec posuer dolor aliquam tellu nibh blandit porttitor elit sit amet pulvinar auctor puru praesent facilisi feugiat mauri qui consectetur lacu maximu non ','test2'),(16,18,'lorem ipsum dolor sit amet ','test2'),(16,19,'suspendiss potenti morbi venenati lorem qui orci tincidunt vel loborti magna facilisi nullam eget vulput tortor donec eu pellentesqu sem aliquam erat volutpat nullam ultric mi ut dapibu mauri quisqu diam augu interdum tellu vel malesuada dignissim ipsum proin fringilla eu sem condimentum donec sed gravida diam ut bibendum ultrici finibu suspendiss ultric tincidunt odio accumsan euismod donec libero qui metu tincidunt rutrum vita sit amet velit ut interdum vita augu vehicula interdum malesuada fame ac ant ipsum primi faucibu donec nec scelerisqu turpi pulvinar euismod diam nunc semper egesta orci dictum tortor bibendum vulput vestibulum ant ipsum primi faucibu orci luctu ultric posuer cubilia cura etiam justo ut est posuer efficitur eget lacu quisqu qui elit erat aliquam interdum in euismod tellu qui dignissim feugiat phasellu nec porta enim ut congu dui feugiat egesta arcu enim ornar ipsum qui dapibu elit lacu eu augu pellentesqu fringilla sapien sit amet dolor vulput dapibu libero aliquam cra mauri arcu porta lectu sit amet molli dictum feli nam odio leo sagitti pellentesqu eget consequat nisi ut ornar bibendum elit vel tristiqu dolor tempor eu suspendiss potenti morbi rhoncu ero ut elementum aliquam elit velit tincidunt justo variu magna nisl loborti elit ','test3'),(16,20,'some highlight text ','ina'),(16,22,'some code text ','ina'),(16,23,'anoth code text big on donec nec scelerisqu turpi pulvinar euismod diam nunc semper egesta orci dictum tortor bibendum vulput vestibulum ant ipsum primi faucibu orci luctu ultric posuer cubilia cura etiam justo ut est posuer efficitur eget lacu quisqu qui elit erat aliquam interdum in euismod tellu qui dignissim feugiat phasellu nec porta enim ut congu dui feugiat egesta arcu enim ornar ipsum qui dapibu elit lacu eu augu pellentesqu fringilla sapien sit amet dolor vulput dapibu libero aliquam cra mauri arcu porta lectu sit amet molli dictum feli nam odio leo sagitti pellentesqu eget consequat nisi ut ornar bibendum elit vel tristiqu dolor tempor eu suspendiss potenti morbi rhoncu ero ut elementum aliquam elit velit tincidunt justo variu magna nisl loborti elit ','ina'),(16,24,'some repli doesnt matter ','test11'),(16,25,'haha good on p ','test11'),(16,26,'what on ','test11'),(16,27,'you noth ','test3'),(16,28,'ina nice code ','test'),(16,29,'test thank ','ina'),(16,30,'test yohoho ','test'),(10,31,'my answer ','test'),(17,32,'you cant vegeta stronger you ','whis'),(17,33,'whi shut daddi angel ','Goku');
/*!40000 ALTER TABLE `processed_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `processed_threads`
--

DROP TABLE IF EXISTS `processed_threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `processed_threads` (
  `Thread_ID` int(11) NOT NULL,
  `Title` varchar(8000) NOT NULL,
  `Post` longtext NOT NULL,
  `Username` varchar(16) NOT NULL,
  `Tags_List` varchar(8000) DEFAULT NULL,
  PRIMARY KEY (`Thread_ID`),
  FULLTEXT KEY `Title` (`Title`,`Post`,`Username`,`Tags_List`),
  FULLTEXT KEY `Title_2` (`Title`),
  FULLTEXT KEY `Post` (`Post`),
  FULLTEXT KEY `Tags_List` (`Tags_List`),
  FULLTEXT KEY `Post_2` (`Post`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `processed_threads`
--

LOCK TABLES `processed_threads` WRITE;
/*!40000 ALTER TABLE `processed_threads` DISABLE KEYS */;
INSERT INTO `processed_threads` VALUES (7,'test thread ','someth meaning ','test',''),(9,'increment mysql updat queri ','made code give  point doesnt work properli mysqlqueri updat memberprofil set point point where userid userid  point variabl user point now it point doesnt what wrong ','test3',' php mysql sql sql-update'),(10,'how import sql file command line mysql ','sql file export phpmyadmin import server command line window server r instal sql file drive command databasenam filesql it work syntax error how import file problem do creat databas first ','test3',' mysql sql command-line import'),(11,'design pattern web base applic ','design simpl webbas applic webbas domaini need advic design pattern respons distribut servlet criteria make servlet etc actual entiti home page option add edit delet earlier servlet option servlet add entiti servlet edit entiti end larg number servlet now chang design my question choos choos respons servlet should servlet entiti process it option forward request servic layer or servlet page process page request forward servic layer also request object forward servic layer not ','test8',' java  design-patterns  jsp  servlets'),(12,'requestdispatcherforward httpservletresponsesendredirect ','what conceptu differ forward sendredirect ','test10',' jsp  redirect  servlets  forward'),(13,'how updat timestamp field mysql tabl ','updat column wai updat time ','test5',' mysql timestamp field'),(14,'first ajax call extrem slow subsequ call run quickli â why ','im simpl jqueri ajax function run extrem slow  second time it call run  second time it call time figur happen speed possibl here function function getnewitemaltapiurl calltyp apikei datatyp returnvalu appendtowrapp  ajax call api return ajax type calltyp url apiurl data apikei datatyp datatyp success functionresult appendtowrapperclosestgameplayareafindgameloaderremov  thing probabl  imag url actual valu var desiredreturn deepvalueresult returnvalu var specialclass  consolelogtypeof desiredreturn typeof desiredreturn  number specialclass number  it url it imag setup  imgag tag ad dom desiredreturntostringsubstr  http appendtowrapperchildrengameimageremov appendtowrapperprependimg classgameimag src desiredreturn   appendtowrapperchildrengamevaluereturnremov appendtowrapperprependp classgamevaluereturn specialclass  desiredreturn p  clear space plai game  currentgamewrapperchildrengameintroremov  show game  currentgamewrapperchildrengameplayarearemoveclasshid  error functionerr consolelogerr  an api im make request giphi api im convinc server issu call api subsequ call speedi ani idea happen make run faster ','test','javascript jquery ajax'),(15,'is ãomniscientomnipotentomnipresentã definit god consist ','god commonli defin omnisci infinit knowledg omnipot unlimit power omnipres present everywher entiti is logic inconsist definit paradox doe god he tomorrow if so els if god happen els he omnisci if cant chang it he omnipot can an omnipot be creat stone heavi lift it do defint god commonli held logic inconsist ','ina','epistemology theology god'),(16,'thread multipl post ','great content ','test','multiple posts in one thread'),(17,'how stronger grand priest ','the titl all vegeta suck ','Goku','saiyans strength grand-priest vegeta-sucks');
/*!40000 ALTER TABLE `processed_threads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reported_posts`
--

DROP TABLE IF EXISTS `reported_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reported_posts` (
  `Report_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Post_ID` int(11) NOT NULL,
  `Reported_By` varchar(16) NOT NULL,
  `Comment` varchar(8000) DEFAULT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddressedBy` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`Report_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reported_posts`
--

LOCK TABLES `reported_posts` WRITE;
/*!40000 ALTER TABLE `reported_posts` DISABLE KEYS */;
INSERT INTO `reported_posts` VALUES (2,33,'test2','Goku is rude','2019-04-20 21:38:42',NULL),(3,20,'test2','The content is not good','2019-04-22 17:28:46',NULL);
/*!40000 ALTER TABLE `reported_posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reported_threads`
--

DROP TABLE IF EXISTS `reported_threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reported_threads` (
  `Report_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Thread_ID` int(11) NOT NULL,
  `Reported_By` varchar(16) NOT NULL,
  `Comment` varchar(8000) DEFAULT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddressedBy` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`Report_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reported_threads`
--

LOCK TABLES `reported_threads` WRITE;
/*!40000 ALTER TABLE `reported_threads` DISABLE KEYS */;
INSERT INTO `reported_threads` VALUES (1,7,'test2',NULL,'2019-04-20 19:55:09','test'),(2,7,'test2','Just wondering if the comment box works','2019-04-20 20:50:26','test');
/*!40000 ALTER TABLE `reported_threads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reported_users`
--

DROP TABLE IF EXISTS `reported_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reported_users` (
  `Report_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(16) NOT NULL,
  `Reported_By` varchar(16) NOT NULL,
  `Comment` varchar(8000) DEFAULT NULL,
  `Timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Adressed_By` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`Report_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reported_users`
--

LOCK TABLES `reported_users` WRITE;
/*!40000 ALTER TABLE `reported_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `reported_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `SNo` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(30) DEFAULT NULL,
  `count` int(11) DEFAULT '1',
  PRIMARY KEY (`SNo`),
  UNIQUE KEY `tag_2` (`tag`),
  KEY `tag` (`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'php',1),(2,'mysql',3),(3,'sql',2),(4,'sql-update',1),(7,'command-line',2),(8,'import',1),(18,'java',1),(19,'design-patterns',1),(20,'jsp',2),(21,'servlets',2),(22,'redirect',1),(23,'forward',1),(44,'timestamp',1),(45,'field',1),(61,'The',1),(62,'tags',1),(63,'don\'t',1),(64,'really',1),(65,'matter',1),(66,'fist',1),(67,'secong',1),(68,'dfskljfk',1),(69,'javascript',1),(70,'jquery',1),(71,'ajax',1),(75,'multiple',1),(76,'posts',1),(77,'in',1),(78,'one',1),(79,'thread',1),(80,'epistemology',1),(81,'theology',1),(82,'god',1),(135,'saiyans',1),(136,'strength',1),(137,'grand-priest',1),(138,'vegeta-sucks',1);
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags_followers`
--

DROP TABLE IF EXISTS `tags_followers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags_followers` (
  `tag` varchar(30) NOT NULL,
  `username` varchar(16) NOT NULL,
  PRIMARY KEY (`tag`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags_followers`
--

LOCK TABLES `tags_followers` WRITE;
/*!40000 ALTER TABLE `tags_followers` DISABLE KEYS */;
INSERT INTO `tags_followers` VALUES ('command-line','test'),('epistemology','test3'),('jquery','test3'),('mysql','test'),('sql','test'),('theology','test3');
/*!40000 ALTER TABLE `tags_followers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thread_votes`
--

DROP TABLE IF EXISTS `thread_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thread_votes` (
  `Thread_ID` int(11) NOT NULL,
  `Username` varchar(16) NOT NULL,
  `Vote` int(11) NOT NULL,
  PRIMARY KEY (`Thread_ID`,`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thread_votes`
--

LOCK TABLES `thread_votes` WRITE;
/*!40000 ALTER TABLE `thread_votes` DISABLE KEYS */;
INSERT INTO `thread_votes` VALUES (7,'test9',1),(10,'test',1),(13,'test',1),(15,'test3',1),(16,'ina',1),(16,'test',1),(16,'test3',1);
/*!40000 ALTER TABLE `thread_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `threads`
--

DROP TABLE IF EXISTS `threads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `threads` (
  `Thread_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(8000) NOT NULL,
  `Post` longtext NOT NULL,
  `Tags_List` varchar(8000) DEFAULT NULL,
  `Username` varchar(16) NOT NULL,
  `Votes` int(11) NOT NULL DEFAULT '0',
  `Timestamp_Created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Timestamp_Modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`Thread_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `threads`
--

LOCK TABLES `threads` WRITE;
/*!40000 ALTER TABLE `threads` DISABLE KEYS */;
INSERT INTO `threads` VALUES (7,'Test Thread','<p>Something meaningful</p>','','test',1,'1993-04-06 08:30:07','1993-04-06 08:30:07',0),(9,'Increment value in mysql update query','<div itemprop=\"text\"><p>I have made this code for giving out +1 point, but it doesn&#39;t work properly.</p><pre><code>mysql_query(&quot;\r\n    UPDATE member_profile \r\n    SET points= &#39; &quot;.$points.&quot; &#39; + 1 \r\n    WHERE user_id = &#39;&quot;.$userid.&quot;&#39;\r\n&quot;);</code></pre><p>the $points variable is the user&acute;s points right now.. I want it to plus one to it.. so example if he had like 5 points, it should be 5+1 = 6.. <strong>but it doesnt, it just changes to 1</strong></p><p>What have i done wrong? thank you</p></div>',' php;mysql;sql;sql-update','test3',0,'2019-03-26 18:07:03','2019-03-26 18:07:03',1),(10,'How to import an SQL file using the command line in MySQL?','<div itemprop=\"text\"><p>I have a <code>.sql</code> file with an export from <code>phpMyAdmin</code>. I want to import it into a different server using the command line.</p><p>I have a <a href=\"http://en.wikipedia.org/wiki/Windows_Server_2008\" rel=\"noreferrer\">Windows Server 2008</a> R2 installation. I placed the <code>.sql</code> file on the <strong><em>C drive</em></strong>, and I tried this command</p><pre><code>database_name &lt; file.sql</code></pre><p>It is not working I get syntax errors.</p><ul><li>How can I import this file without a problem?</li><li>Do I need to create a database first?</li></ul></div>',' mysql;sql;command-line;import','test3',1,'2019-03-26 18:09:44','2019-04-12 18:09:54',1),(11,'Design Patterns web based applications','<div itemprop=\"text\"><p>I am designing a simple web-based application. I am new to this web-based domain.I needed your advice regarding the design patterns like how responsibility should be distributed among Servlets, criteria to make new Servlet, etc.</p><p>Actually, I have few entities on my home page and corresponding to each one of them we have few options like add, edit and delete. Earlier I was using one Servlet per options like Servlet1 for add entity1, Servlet2 for edit entity1 and so on and in this way we ended up having a large number of servlets.</p><p>Now we are changing our design. My question is how you exactly choose how you choose the responsibility of a servlet. Should we have one Servlet per entity which will process all it&#39;s options and forward request to the service layer. Or should we have one servlet for the whole page which will process the whole page request and then forward it to the corresponding service layer? Also, should the request object forwarded to service layer or not.</p></div>',' java; design-patterns; jsp; servlets','test8',0,'2019-03-29 15:17:08','2019-03-29 15:17:08',1),(12,'RequestDispatcher.forward() vs HttpServletResponse.sendRedirect()','<div itemprop=\"text\"><p>What is the conceptual difference between <code>forward()</code> and <code>sendRedirect()</code>?</p></div>',' jsp ;redirect; servlets ;forward','test10',0,'2019-03-29 15:39:01','2019-03-29 15:39:01',1),(13,'How to update a timestamp field of a mysql table ?','<p>have tried to update the column in different ways, but am not able to update the time</p>',' mysql;timestamp;field','test5',1,'2019-03-29 18:44:41','2019-03-29 18:44:41',1),(14,'First ajax call goes extremely slow, subsequent calls run quickly â?? why?','<div itemprop=\"text\"><p>I&#39;m using a simple jQuery AJAX function that runs extremely slow (10-15 seconds) the first time it&#39;s called, and then runs normally at &lt;1 - 2 seconds each time it&#39;s called after that first time. I cannot figure out why this is happening but need to speed it up as much as possible. Here is the function:</p><pre><code>function getNewItemAlt(apiUrl, callType, apiKey, dataType, returnValue, appendToWrapper) {\r\n// ajax call to the api\r\n  return $.ajax({\r\n    type: callType,\r\n    url: apiUrl,\r\n    data: apiKey,\r\n    dataType: dataType,\r\n    success: function(result) {\r\n\r\n        appendToWrapper.closest(&#39;.game_play_area&#39;).find(&#39;.game_loader&#39;).remove();\r\n\r\n        // this is the thing that we want (probably either\r\n        // an image url or an actual value)\r\n        var desiredReturn = deepValue(result, returnValue);\r\n\r\n        var specialClass = &#39;&#39;;\r\n        console.log(typeof desiredReturn)\r\n        if (typeof desiredReturn === &#39;number&#39;) {\r\n            specialClass = &#39;number&#39;\r\n        }\r\n\r\n        // if it&#39;s a URL then it&#39;s an image and can be setup \r\n        // in an imgage tag and added to the dom\r\n        if (desiredReturn.toString().substring(0, 4) == &quot;http&quot;) {\r\n            $(appendToWrapper).children(&#39;.game_image&#39;).remove();\r\n            $(appendToWrapper).prepend(&#39;&lt;img class=&quot;game_image&quot; src=&quot;&#39; + desiredReturn + &#39;&quot; /&gt;&#39;);\r\n        } else {\r\n            $(appendToWrapper).children(&#39;.game_value_return&#39;).remove();\r\n            $(appendToWrapper).prepend(&#39;&lt;p class=&quot;game_value_return &#39; + specialClass + &#39;&quot;&gt;&#39; + desiredReturn + &#39;&lt;/p&gt;&#39;);\r\n        }\r\n\r\n\r\n        // clear the space to play the game\r\n        // $(currentGameWrapper).children(&#39;.game_intro&#39;).remove();\r\n\r\n        // show the game \r\n        // currentGameWrapper.children(&#39;.game_play_area&#39;).removeClass(&#39;hide&#39;);\r\n\r\n    },\r\n    error: function(err) {\r\n        console.log(err);\r\n    }\r\n});\r\n}</code></pre><p>An example of an API that I&#39;m making a request to is the Giphy API. I&#39;m not convinced this is a server issue because it happens only on the first call to the api and then the subsequent calls are speedy.</p><p>Any ideas why this is happening and what can be done to make this run faster?</p></div>','javascript;jquery;ajax','test',0,'2019-04-06 07:39:22','2019-04-06 07:39:22',1),(15,'Is the Ã¢??omniscient-omnipotent-omnipresentÃ¢?? definition of God consistent?','<div itemprop=\"text\"><p><a href=\"http://en.wikipedia.org/wiki/God\">God</a> is commonly defined as an <a href=\"http://en.wikipedia.org/wiki/Omniscience\">omniscient</a> (infinite knowledge), <a href=\"http://en.wikipedia.org/wiki/Omnipotence\">omnipotent</a> (unlimited power), <a href=\"http://en.wikipedia.org/wiki/Omnipresence\">omnipresent</a> (present everywhere) entity.</p><p>Is there any logical <a href=\"http://en.wikipedia.org/wiki/Consistency\">inconsistency</a> in this definition?</p><p>I have seen several paradoxes like below</p><blockquote><p>Does God know what he&#39;s going to do &nbsp;tomorrow? If so, could he do something &nbsp;else?&quot; If God knows what will happen, &nbsp;and does something else, he&#39;s not &nbsp;omniscient. If he knows and can&#39;t &nbsp;change it, he&#39;s not omnipotent.</p>&nbsp; &nbsp;<p>&quot;Can &#39;an omnipotent being&#39; create a &nbsp;stone so heavy that it cannot lift &nbsp;it?&quot;</p></blockquote><p><em>Do they mean that the defintion of God ( as commonly held) is logically inconsistent?</em></p></div>','epistemology;theology;god','ina',1,'2019-04-06 08:19:48','2019-04-12 18:14:46',1),(16,'Thread with multiple posts','<p><span style=\"color: rgb(184, 49, 47);\"><strong><span style=\"font-size: 24px;\"><u><span style=\"font-family: Verdana,Geneva,sans-serif;\">Great content</span></u></span></strong></span></p>','multiple;posts;in;one;thread','test',3,'2019-04-08 19:55:08','2019-04-08 19:55:08',1),(17,'How to get stronger than Grand Priest?','<p>The title says it all!! and Vegeta sucks!</p>','saiyans;strength;grand-priest;vegeta-sucks','Goku',0,'2019-04-17 06:35:04','2019-04-18 07:32:47',1);
/*!40000 ALTER TABLE `threads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Username` varchar(16) COLLATE utf8_bin NOT NULL,
  `Password` varchar(64) COLLATE utf8_bin NOT NULL,
  `Email` varchar(50) COLLATE utf8_bin NOT NULL,
  `FollowersCount` int(10) NOT NULL DEFAULT '0',
  `FollowingCount` int(10) NOT NULL DEFAULT '0',
  `FollowingTagsCount` int(10) NOT NULL DEFAULT '0',
  `Points` int(10) NOT NULL DEFAULT '1',
  `AvatarPath` varchar(8000) COLLATE utf8_bin NOT NULL DEFAULT '/Hanashi/images/user.png',
  `Privilege` int(11) NOT NULL DEFAULT '4',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email_index` (`Email`),
  UNIQUE KEY `username_index` (`Username`),
  KEY `users_username_index` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','fx7DIUfWYgKzLEsztpT7OUzGzZu8G25r4V6y0AijHr4=','hanashiteam@gmail.com',2,0,0,-1,'/Hanashi/images/admin.png',1),(2,'test','n4bQgYhMfWWaL+qgxVrQFaO/TxsrC4Is0V1sFbDwCgg=','testemail',2,6,0,107,'/Hanashi/images/user.png',2),(3,'test2','YDA64iuZiGG847KPM+7BvnWKITyGyTwHbb6fVYwRx1I=','test2email',2,3,0,15,'/Hanashi/images/user.png',4),(4,'test3','/WGgOvT3fYcPwh4F5+gGeAlcktgIz7O1wnnuBMdKyhM=','test3email',1,1,0,2,'/Hanashi/images/user.png',4),(5,'test4','pOYk1obgPtJ2fAq9hcFEJrCxFX0s6B0nu0/k9vAdaIo=','test4email',0,0,0,1,'/Hanashi/images/user.png',4),(6,'test5','oUDAwe2i3vK4MDY7o2KqTX0lXCYpYFRIIfVW4WZhtv8=','test5email',1,0,0,8,'/Hanashi/images/user.png',4),(7,'test8','H5v+sV/uihDE0HEcfrDAg5YhI+GRjkYbalCOcUbBibI=','test8email@somo.com',1,0,0,1,'/Hanashi/images/user.png',4),(8,'test9','tEUQNNO2WQBgzpSEoouI3TMqgKIq6OOcnFy3NXqybJ8=','test9@something.com',1,0,0,1,'/Hanashi/images/user.png',4),(9,'test10','7Cc4/rK7sLx4PrRmeQM5FBY3K6bti43dvrvbN+UQJHM=','test10\'semail',0,1,0,1,'/Hanashi/images/user.png',4),(10,'test11','dE6p7G+gqD6XZLTjI9W+a1WlrM/H/kwI6rao3h/KSFU=','test11email',1,0,0,1,'/Hanashi/images/user.png',4),(11,'test21','rv1XyMKv2q0KU1KwzocTGoWgj1yHqH8Wbwzh4hP0wP0=','test21@domain.com',0,0,0,1,'/Hanashi/images/user.png',4),(12,'test22','dZz94mWq3bb3KO0I2Xhiu9m1b9Od6XoEnGQLTFtwqsk=','test22@domain.com',0,0,0,1,'/Hanashi/images/user.png',4),(13,'test1','G08OmFGXGZjnMgeFRMlrNsPQHO33yqMyNZ1vHYNWcBQ=','test1@domain.com',0,0,0,1,'/Hanashi/images/user.png',4),(14,'test44','rVntd7/TdXqHkzLpVkTjIvCAi8lMYhejSQ+F8XZEi30=','test44@domain.com',0,0,0,1,'/Hanashi/images/user.png',4),(15,'test51','KdddJY4D3IdYOC1r15NBRnCGASXISIYSJNHozA4omcY=','test51@gmail.com',0,0,0,1,'/Hanashi/images/user.png',4),(16,'ina','T8grJq7LR9KGjE7741gXMqPny8xsLvsyBiwIFwoF7rg=','zuma',0,0,0,3,'/Hanashi/images/user.png',4),(17,'Goku','46noi5KG2ractpKbvOMY1zXmQFAv/fu0xcczJse7+I4=','kakarot@saiyans.com',0,0,0,1,'/Hanashi/images/user.png',4),(18,'whis','AnjgSZuq5geVOH3fBxpmDUpQkozLxFWzO1TLGzxTEfc=','whis@daddysangel.com',0,0,0,101,'/Hanashi/images/user.png',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-04-23 13:10:29
