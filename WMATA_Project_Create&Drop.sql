USE BUDT703_Project_0506_09;
--SQL drop tables
DROP TABLE IF EXISTS [Metro.BusPerformance];
DROP TABLE IF EXISTS [Metro.RailPerformance];
DROP TABLE IF EXISTS [Metro.CalendarDate];
DROP TABLE IF EXISTS [Metro.BusRoute];
DROP TABLE IF EXISTS [Metro.Station];

-- Create SQL tables
CREATE TABLE [Metro.Station](
	stationID CHAR (5) NOT NULL, 
	stationName VARCHAR (200),
	stationPrimaryLine VARCHAR (200),
	stationSecondaryLine VARCHAR (200),
	stationAddress VARCHAR (200), 
	stationJurisdiction VARCHAR (200),
	CONSTRAINT pk_Station_StationID PRIMARY KEY (StationID));

CREATE TABLE [Metro.BusRoute](
	busRouteID CHAR (30) NOT NULL,
	busRouteName CHAR (35),
	busRouteServiceType VARCHAR (30),
	CONSTRAINT pk_busRoute_busRouteID PRIMARY KEY (busRouteID));

CREATE TABLE [Metro.CalendarDate](
	calendarDateID DATE NOT NULL,
	calendarFullDate DATE,
	calendarMonthName VARCHAR (10),
	calendarQuarter INTEGER,
	calendarYear INTEGER,
	calendarDayOfWeek VARCHAR (10),
	CONSTRAINT pk_calendarDate_calendarDateID PRIMARY KEY (calendarDateID));

CREATE TABLE [Metro.RailPerformance](
	calendarDateID DATE NOT NULL,
	stationID CHAR (5) NOT NULL,
	railRidershipEntries INTEGER,
	railRidershipExits INTEGER,
	railCrimeIncidentCount INTEGER,
	railCustomerInjuryCount INTEGER,
	railEscalatorAvailabilityPct DECIMAL (5,2),
	CONSTRAINT pk_RailPerformance_stationID_calendarDateID PRIMARY KEY (stationID,calendardateID),
	CONSTRAINT fk_RailPerformance_Station FOREIGN KEY (stationID)
		REFERENCES [Metro.Station] (stationID)
	    ON DELETE NO ACTION ON UPDATE CASCADE, 
	CONSTRAINT fk_RailPerformance_calendarDate FOREIGN KEY (calendardateID)
		REFERENCES [Metro.Calendardate] (calendarDateID)
		ON DELETE CASCADE ON UPDATE CASCADE);		

CREATE TABLE [Metro.BusPerformance]( 
	calendarDateID DATE NOT NULL, 
	busRouteID CHAR (30) NOT NULL,
	busPerformanceBoardings INTEGER,
	busPerformanceTimeDepartures INTEGER ,
	busPerformanceTotalDepartures INTEGER,
	busPerformanceScheduledTrips INTEGER,
	busPerformanceActualTrips INTEGER,
	CONSTRAINT pk_BusPerformance PRIMARY KEY (calendarDateID,busRouteID),
	CONSTRAINT fk_BusPerformance_calendar FOREIGN KEY (calendarDateID)
		REFERENCES [Metro.CalendarDate] (calendarDateID)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_BusPerformance_busRoute FOREIGN KEY (busRouteID)
		REFERENCES [Metro.BusRoute] (busRouteID)
		ON DELETE  CASCADE ON UPDATE CASCADE);