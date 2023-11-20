"use client";
import React from "react";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";

import FileInput from "@/components/upload-file/FileInput";
import { Button } from "@/components/ui/button";

// string name = "";
// string description = "";
// string image = "";
// string price = "";

const page = () => {
  return (
    <div className="w-full min-h-screen p-4 grid place-content-center">
      <div className="flex flex-col gap-4 w-[48rem] border py-8 px-6 rounded bg-white">
        <p className="py-">Add New Product</p>
        <hr className="border-black" />
        <div className="flex gap-4 ">
          <div className="w-1/2">
            <label>Name</label>
            <Input placeholder="name..." />
          </div>
          <div className="w-1/2">
            <label>Price</label>
            <Input placeholder="price" type="number" min={0.01} step={0.01} />
          </div>
        </div>
        <FileInput />
        <div>
          <label>Description</label>
          <Textarea
            placeholder="Lorem ipsum dolor sit amet consectetur adipisicing elit. Sapiente, nisi."
            className="resize-none"
          />
        </div>
        <Button className="bg-black text-white">Submit</Button>
      </div>
    </div>
  );
};

export default page;
