SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Connect 4`
--

-- --------------------------------------------------------

--
-- Table structure for table `Language`
--

CREATE TABLE `Language` (
  `LanguageKey` int NOT NULL,
  `LanguageName` varchar(25) NOT NULL,
  `CountryofOrigin` varchar(25) DEFAULT NULL,
  `Difficulty` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Language`
--

INSERT INTO `Language` (`LanguageKey`, `LanguageName`, `CountryofOrigin`, `Difficulty`) VALUES
(1, 'Spanish', 'Spain', 'Easy'),
(2, 'French', 'France', 'Easy'),
(3, 'Mandarin', 'China', 'Hard'),
(4, 'English', 'England', 'Medium'),
(5, 'Portuguese ', 'Portugal', 'Easy');

-- --------------------------------------------------------

--
-- Table structure for table `LearnLanguage`
--

CREATE TABLE `LearnLanguage` (
  `LearnID` int NOT NULL,
  `UserID` int DEFAULT NULL,
  `LanguageKey` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `LearnLanguage`
--

INSERT INTO `LearnLanguage` (`LearnID`, `UserID`, `LanguageKey`) VALUES
(1, 3, 1),
(2, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `TeachLanguage`
--

CREATE TABLE `TeachLanguage` (
  `TeachID` int NOT NULL,
  `UserID` int DEFAULT NULL,
  `LanguageKey` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `TeachLanguage`
--

INSERT INTO `TeachLanguage` (`TeachID`, `UserID`, `LanguageKey`) VALUES
(1, 1, 4),
(2, 2, 5);

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `UserID` int NOT NULL,
  `FirstName` text NOT NULL,
  `LastName` text NOT NULL,
  `Email` text NOT NULL,
  `Role` text NOT NULL,
  `Username` text NOT NULL,
  `Password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`UserID`, `FirstName`, `LastName`, `Email`, `Role`, `Username`, `Password`) VALUES
(1, 'Olivia', 'Bennet', 'oliviabennet@gmail.com', 'Tutor', 'obennet1', '1234'),
(2, 'Ethan', 'Carter', 'ethancarter@hotmail.com', 'Tutor', 'carter22', 'password'),
(3, 'Sophia ', 'Mitchell', 'sophiamitchell23@gmail.com', 'Student', 'sophieishere', 'mitchell23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Language`
--
ALTER TABLE `Language`
  ADD PRIMARY KEY (`LanguageKey`);

--
-- Indexes for table `LearnLanguage`
--
ALTER TABLE `LearnLanguage`
  ADD PRIMARY KEY (`LearnID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `LanguageKey` (`LanguageKey`);

--
-- Indexes for table `TeachLanguage`
--
ALTER TABLE `TeachLanguage`
  ADD PRIMARY KEY (`TeachID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `LanguageKey` (`LanguageKey`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Language`
--
ALTER TABLE `Language`
  MODIFY `LanguageKey` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `LearnLanguage`
--
ALTER TABLE `LearnLanguage`
  MODIFY `LearnID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `TeachLanguage`
--
ALTER TABLE `TeachLanguage`
  MODIFY `TeachID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `UserID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `LearnLanguage`
--
ALTER TABLE `LearnLanguage`
  ADD CONSTRAINT `learnlanguage_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE,
  ADD CONSTRAINT `learnlanguage_ibfk_2` FOREIGN KEY (`LanguageKey`) REFERENCES `Language` (`LanguageKey`) ON DELETE CASCADE;

--
-- Constraints for table `TeachLanguage`
--
ALTER TABLE `TeachLanguage`
  ADD CONSTRAINT `teachlanguage_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`) ON DELETE CASCADE,
  ADD CONSTRAINT `teachlanguage_ibfk_2` FOREIGN KEY (`LanguageKey`) REFERENCES `Language` (`LanguageKey`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;