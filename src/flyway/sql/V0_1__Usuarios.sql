SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

CREATE TABLE `horaconta`.`users` (
 `id` int(10) NOT NULL,
 `username` varchar(32) NOT NULL,
 `password` varchar(64) NOT NULL,
 `email` varchar(50) NOT NULL,
 `profile_icon` varchar(255) NOT NULL,
 `apikey` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;


INSERT INTO `horaconta`.`users` (`id`, `username`, `password`, `email`, `profile_icon`, `apikey`) VALUES
(1, 'rog', '000c285457fc971f862a79b786476c78812c8897063c6fa9c045f579a3b2d63f', 'rogeriotadim@gmail.com', 'd0763edaa9d9bd2a9516280e9044d885'),
(2, 'pat', '4d6b96d1e8f9bfcd28169bafe2e17da6e1a95f71e8ca6196d3affb4f95ca809f', 'sratadim.pat@gmail.com', 'd0763edaa9d9bd2a9516280e9044d885');

ALTER TABLE `messages`
 ADD PRIMARY KEY (`id`),
 ADD KEY `user_id` (`user_id`);

ALTER TABLE `users`
 ADD PRIMARY KEY (`id`);

ALTER TABLE `users`
 MODIFY `id` int(10) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;