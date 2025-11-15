
import React, { useState } from "react";

export default function EmployeeAttendanceApp() {
  const [loggedIn, setLoggedIn] = useState(false);
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [attendance, setAttendance] = useState({});

  const daysInMonth = (year, month) => new Date(year, month + 1, 0).getDate();

  const currentDate = new Date();
  const year = currentDate.getFullYear();
  const month = currentDate.getMonth();
  const days = daysInMonth(year, month);

  const handleLogin = () => {
    if (username && password) {
      setLoggedIn(true);
    }
  };

  const toggleStatus = (day) => {
    const newStatus = { ...attendance };
    if (!newStatus[day]) newStatus[day] = { status: "present", note: "" };
    else if (newStatus[day].status === "present") newStatus[day].status = "absent";
    else if (newStatus[day].status === "absent") newStatus[day].status = "present";
    setAttendance(newStatus);
  };

  const updateNote = (day, value) => {
    const newStatus = { ...attendance };
    if (!newStatus[day]) newStatus[day] = { status: "present", note: value };
    else newStatus[day].note = value;
    setAttendance(newStatus);
  };

  if (!loggedIn) {
    return (
      <div className="w-full h-screen flex items-center justify-center bg-gray-100">
        <div className="p-8 bg-white shadow-xl rounded-2xl w-96 space-y-4">
          <h2 className="text-2xl font-bold text-center">Employee Login</h2>
          <input
            placeholder="Username"
            className="w-full p-2 border rounded-xl"
            onChange={(e) => setUsername(e.target.value)}
          />
          <input
            placeholder="Password"
            type="password"
            className="w-full p-2 border rounded-xl"
            onChange={(e) => setPassword(e.target.value)}
          />
          <button
            className="w-full p-2 bg-blue-500 text-white rounded-xl"
            onClick={handleLogin}
          >
            Login
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="p-6">
      <h1 className="text-3xl font-bold mb-4 text-center">Attendance Calendar</h1>
      <h2 className="text-xl text-center mb-6">
        {currentDate.toLocaleString("default", { month: "long" })} {year}
      </h2>

      <div className="grid grid-cols-7 gap-4">
        {[...Array(days)].map((_, i) => {
          const day = i + 1;
          const status = attendance[day]?.status;
          const note = attendance[day]?.note || "";

          return (
            <div
              key={day}
              className={`p-4 rounded-2xl shadow-md cursor-pointer border text-center ${
                status === "present"
                  ? "bg-green-300"
                  : status === "absent"
                  ? "bg-red-300"
                  : "bg-gray-200"
              }`}
              onClick={() => toggleStatus(day)}
            >
              <div className="font-bold">{day}</div>
              <textarea
                placeholder="Add note..."
                className="mt-2 p-1 w-full rounded-xl text-sm"
                value={note}
                onChange={(e) => updateNote(day, e.target.value)}
              />
            </div>
          );
        })}
      </div>
    </div>
  );
}


