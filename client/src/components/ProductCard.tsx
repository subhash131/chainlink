import React from "react";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import Image from "next/image";

const ProductCard = () => {
  return (
    <div className="h-[80vh] w-80">
      <Card className="pb-4 overflow-hidden">
        <Image
          src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e6da41fa-1be4-4ce5-b89c-22be4f1f02d4/air-force-1-07-shoes-WrLlWX.png"
          alt="image"
          width={100}
          height={100}
          className="w-full h-64 object-cover"
        ></Image>
        <CardHeader className="py-2">
          <CardTitle className="text-lg">Nike Air Force 1 '07</CardTitle>
          <CardDescription>Men's shoes</CardDescription>
          <CardDescription>Owner : 0x42o405...90e2</CardDescription>
        </CardHeader>
        <CardFooter className="justify-between py-2">
          <CardTitle className="text-base">Price: 4.5$</CardTitle>
          <Button>Buy</Button>
        </CardFooter>
      </Card>
    </div>
  );
};

export default ProductCard;
