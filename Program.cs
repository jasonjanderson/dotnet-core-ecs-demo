using System;
using System.Runtime.InteropServices;
using static System.Console;
using System.Threading;

/*
  Simple program that outputs a log message every 10 seconds

  Example:
  OS: Linux 4.9.49-moby #1 SMP Wed Sep 27 00:36:29 UTC 2017

  Container has been running for 0 seconds
  Container has been running for 10 seconds
  Container has been running for 20 seconds
  Container has been running for 30 seconds
  Container has been running for 40 seconds
  ...
 */
public static class Program
{
  public static void Main(string[] args) 
  {
        Console.CancelKeyPress += delegate {
          Environment.Exit(0);
        };

        WriteLine($"OS: {RuntimeInformation.OSDescription}");
        WriteLine();

        int seconds = 0;
        while (true) {
          WriteLine($"Container has been running for {seconds} seconds");
          seconds+=10;
          Thread.Sleep(10000);
        }
  }
}