import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class WebshopJP {

    private static final String URL = "jdbc:mysql://localhost:3306/WebshopJP";
    private static final String USER = "root";
    private static final String PASSWORD = "Hejhej123!";

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement()) {

            // Fråga 1
            String query1 = "SELECT DISTINCT c.FirstName AS Förnamn, c.LastName AS Efternamn " +
                    "FROM Customers c " +
                    "JOIN Orders o ON c.CustomerID = o.CustomerID " +
                    "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                    "JOIN Products p ON od.ProductID = p.ProductID " +
                    "WHERE p.Color = 'Svart' " +
                    "AND p.Size = '38' " +
                    "AND p.Brand = 'Levis';";
            try (ResultSet rs1 = stmt.executeQuery(query1)) {
                System.out.println("Kunder som har köpt svarta byxor i storlek 38 av märket Sweetpants:");
                while (rs1.next()) {
                    System.out.println(rs1.getString("Förnamn") + " " + rs1.getString("Efternamn"));
                }
            }

            // Fråga 2
            String query2 = "SELECT c.CategoryName AS Kategori, COUNT(p.ProductID) AS AntalProdukter " +
                    "FROM ProductCategories pc " +
                    "JOIN Categories c ON pc.CategoryID = c.CategoryID " +
                    "JOIN Products p ON pc.ProductID = p.ProductID " +
                    "GROUP BY c.CategoryName;";
            try (ResultSet rs2 = stmt.executeQuery(query2)) {
                System.out.println("\nAntal produkter per kategori:");
                while (rs2.next()) {
                    System.out.println(rs2.getString("Kategori") + ": " + rs2.getInt("AntalProdukter"));
                }
            }

            // Fråga 3
            String query3 = "SELECT c.FirstName AS Förnamn, c.LastName AS Efternamn, SUM(p.Price * od.Quantity) AS TotaltHandlat " +
                    "FROM Customers c " +
                    "JOIN Orders o ON c.CustomerID = o.CustomerID " +
                    "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                    "JOIN Products p ON od.ProductID = p.ProductID " +
                    "GROUP BY c.CustomerID;";
            try (ResultSet rs3 = stmt.executeQuery(query3)) {
                System.out.println("\nTotalt handlat per kund:");
                while (rs3.next()) {
                    System.out.println(rs3.getString("Förnamn") + " " + rs3.getString("Efternamn") + ": " + rs3.getDouble("TotaltHandlat"));
                }
            }

            // Fråga 4
            String query4 = "SELECT c.City AS Ort, SUM(p.Price * od.Quantity) AS TotaltBeställningsvärde " +
                    "FROM Orders o " +
                    "JOIN Customers c ON o.CustomerID = c.CustomerID " +
                    "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                    "JOIN Products p ON od.ProductID = p.ProductID " +
                    "GROUP BY c.City " +
                    "HAVING SUM(p.Price * od.Quantity) > 1000;";
            try (ResultSet rs4 = stmt.executeQuery(query4)) {
                System.out.println("\nTotalt beställningsvärde per ort där värdet är större än 1000 kr:");
                while (rs4.next()) {
                    System.out.println(rs4.getString("Ort") + ": " + rs4.getDouble("TotaltBeställningsvärde"));
                }
            }

            // Fråga 5
            String query5 = "SELECT p.Name AS Produktnamn, SUM(od.Quantity) AS TotaltSålda " +
                    "FROM OrderDetails od " +
                    "JOIN Products p ON od.ProductID = p.ProductID " +
                    "GROUP BY p.ProductID " +
                    "ORDER BY TotaltSålda DESC " +
                    "LIMIT 5;";
            try (ResultSet rs5 = stmt.executeQuery(query5)) {
                System.out.println("\nTopp-5 mest sålda produkter:");
                while (rs5.next()) {
                    System.out.println(rs5.getString("Produktnamn") + ": " + rs5.getInt("TotaltSålda"));
                }
            }

            // Fråga 6
            String query6 = "SELECT DATE_FORMAT(o.OrderDate, '%Y-%m') AS Månad, SUM(p.Price * od.Quantity) AS TotalaFörsäljningen " +
                    "FROM Orders o " +
                    "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                    "JOIN Products p ON od.ProductID = p.ProductID " +
                    "GROUP BY Månad " +
                    "ORDER BY TotalaFörsäljningen DESC " +
                    "LIMIT 1;";
            try (ResultSet rs6 = stmt.executeQuery(query6)) {
                System.out.println("\nMånad med största försäljningen:");
                while (rs6.next()) {
                    System.out.println(rs6.getString("Månad") + ": " + rs6.getDouble("TotalaFörsäljningen"));
                }
            }

        } catch (SQLException e) {
            System.err.println("Ett SQL-fel uppstod: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

