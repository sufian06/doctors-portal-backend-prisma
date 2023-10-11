/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/no-unused-vars */
import {
  PrismaClientKnownRequestError,
  PrismaClientValidationError,
} from '@prisma/client/runtime/library'
import { NextFunction, Request, Response } from 'express'
import httpStatus from 'http-status'
import config from '../../config'

export const globalErrorHandler = (
  err: any,
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  let statusCode = httpStatus.BAD_REQUEST
  let message =
    config.env === 'development' ? err.message : 'Something went wrong'

  if (config.env === 'development') {
    if (err instanceof PrismaClientKnownRequestError) {
      statusCode = 400
      const lines = err.message.trim().split('\n')
      message = lines[lines.length - 1]
    } else if (err instanceof PrismaClientValidationError) {
      statusCode = 400
      const lines = err.message.trim().split('\n')
      message = lines[lines.length - 1]
    } else if (err instanceof Error) {
      statusCode = httpStatus.BAD_REQUEST
      message = err.message
    }
  }

  res.status(statusCode).json({
    errorName: err.name,
    success: false,
    message: message,
    // errorStack: err.stack,
  })
}
