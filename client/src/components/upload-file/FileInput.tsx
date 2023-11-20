import React from "react";
import "./styles.css";

const FileInput = () => {
  return (
    <div className="card border rounded">
      <p>Product Image</p>
      <div className="drop_box">
        <header>
          <h4>Select File here</h4>
        </header>
        <p>Files Supported: jpeg, jpg, png.</p>
        <input
          type="file"
          hidden
          accept=".png,.jpeg,.jpg"
          id="productImg"
          className="hidden"
        />
        <label
          htmlFor="productImg"
          className="btn bg-black rounded cursor-pointer"
        >
          Choose File
        </label>
      </div>
    </div>
  );
};

export default FileInput;
