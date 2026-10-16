package com.fashionstore.dao;

import com.fashionstore.model.User;
import java.sql.SQLException;

public interface UserDAO {

    boolean registerUser(User user) throws SQLException;

    User findById(int userId) throws SQLException;

    User findByEmail(String email) throws SQLException;

    boolean updateUser(User user) throws SQLException;

    boolean updatePassword(int userId, String hashedPassword)
            throws SQLException;
}