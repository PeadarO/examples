package com.truward.brikar.time.support;

import com.truward.brikar.time.TimeSource;

import java.util.concurrent.TimeUnit;

/**
 * Implementation of {@link com.truward.brikar.time.TimeSource} that uses {@link System#nanoTime()} in order
 * to retrieve current time. Note, that the returned value is measured in nanoseconds.
 *
 * @author Alexander Shabanov
 */
public final class HighPrecisionTimeSource implements TimeSource {
  public static final TimeSource INSTANCE = new HighPrecisionTimeSource();

  private HighPrecisionTimeSource() {
  }

  @Override
  public long currentTime() {
    return System.nanoTime();
  }

  @Override
  public TimeUnit getTimeUnit() {
    return TimeUnit.NANOSECONDS;
  }
}
