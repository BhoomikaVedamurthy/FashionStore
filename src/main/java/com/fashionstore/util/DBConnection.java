package com.fashionstore.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Creates database connections.
 *
 * Settings are read in this order (first one found wins):
 *   1. Environment variables: DB_URL, DB_USER, DB_PASSWORD
 *   2. A db.properties file on the classpath (src/main/resources/db.properties)
 *   3. Local defaults (no password)
 *
 * db.properties is ignored by Git, so real credentials are never committed.
 * Copy db.properties.example to db.properties and put your own values in it.
 */
public class DBConnection {

    private static final Properties FILE_PROPS = new Properties();

    static {
        try (InputStream in = DBConnection.class
                .getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                FILE_PROPS.load(in);
            }
        } catch (IOException e) {
            // Fall back to environment variables / defaults.
        }
    }

    private static String setting(String envName, String propName,
                                  String defaultValue) {
        String value = System.getenv(envName);
        if (value == null || value.isEmpty()) {
            value = FILE_PROPS.getProperty(propName, defaultValue);
        }
        return value;
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }

        String url = setting("DB_URL", "db.url",
                "jdbc:mysql://localhost:3306/fashion_store");
        String user = setting("DB_USER", "db.user", "root");
        String password = setting("DB_PASSWORD", "db.password", "");

        return DriverManager.getConnection(url, user, password);
    }
}
