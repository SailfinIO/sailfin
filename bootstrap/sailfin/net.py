"""
Sailfin net module - HTTP and networking utilities.
"""
import asyncio
import aiohttp
import json
import os
from typing import Dict, Any, Optional, Union, List, Callable
from dataclasses import dataclass


class WebSocketClient:
    """Mock WebSocket client."""

    def __init__(self):
        self._message_handler = None

    def onMessage(self, handler: Callable[[str], None]):
        """Set message handler."""
        self._message_handler = handler
        # Simulate receiving a message for demo
        if handler:
            handler("Hello from WebSocket client!")

    def send(self, message: str):
        """Send message to client."""
        print(f"WebSocket: Sending message: {message}")


class WebSocketServer:
    """Mock WebSocket server."""

    def __init__(self, config: Dict[str, Any]):
        self.port = config.get("port", 8080)
        self._clients = [WebSocketClient()]  # Mock client for demo

    def clients(self) -> List[WebSocketClient]:
        """Get list of connected clients."""
        return self._clients


class WebSocketModule:
    """WebSocket module with serve function."""

    @staticmethod
    def serve(config: Dict[str, Any]) -> WebSocketServer:
        """Create and return a WebSocket server."""
        return WebSocketServer(config)


# Create websocket module instance
websocket = WebSocketModule()


@dataclass
class Request:
    """HTTP Request object."""
    method: str
    url: str
    headers: Dict[str, str]
    body: Optional[str] = None


@dataclass
class Response:
    """HTTP Response object."""
    status: int
    body: str
    headers: Optional[Dict[str, str]] = None

    def __post_init__(self):
        if self.headers is None:
            self.headers = {}

    @property
    def json(self) -> Any:
        """Parse response body as JSON."""
        return json.loads(self.body)


class HttpClient:
    """HTTP client for making requests."""

    def __init__(self):
        self._session = None

    async def _get_session(self):
        """Get or create aiohttp session."""
        if self._session is None:
            self._session = aiohttp.ClientSession()
        return self._session

    async def get(self, url: str, headers: Dict[str, str] = None) -> Response:
        """Make HTTP GET request."""
        session = await self._get_session()
        async with session.get(url, headers=headers or {}) as resp:
            body = await resp.text()
            return Response(
                status=resp.status,
                headers=dict(resp.headers),
                body=body
            )

    async def post(self, url: str, data: Union[str, Dict[str, Any]] = None,
                   headers: Dict[str, str] = None) -> Response:
        """Make HTTP POST request."""
        session = await self._get_session()

        if isinstance(data, dict):
            data = json.dumps(data)
            headers = headers or {}
            headers['Content-Type'] = 'application/json'

        async with session.post(url, data=data, headers=headers or {}) as resp:
            body = await resp.text()
            return Response(
                status=resp.status,
                headers=dict(resp.headers),
                body=body
            )

    async def close(self):
        """Close the HTTP session."""
        if self._session:
            await self._session.close()
            self._session = None


# Global HTTP client instance
http = HttpClient()


async def serve(handler, host: str = "localhost", port: int = 8000):
    """
    Simple HTTP server.

    Args:
        handler: Async function that takes (request: Request) -> Response
        host: Host to bind to
        port: Port to bind to
    """
    import os
    from aiohttp import web

    async def aiohttp_handler(request):
        # Convert aiohttp request to Sailfin Request
        body = await request.text() if request.body_exists else None
        sailfin_request = Request(
            method=request.method,
            url=str(request.url),
            headers=dict(request.headers),
            body=body
        )

        # Call the user handler
        response = await handler(sailfin_request)

        # Convert Sailfin Response to aiohttp response
        return web.Response(
            text=response.body,
            status=response.status,
            headers=response.headers
        )

    app = web.Application()
    app.router.add_route('*', '/{path:.*}', aiohttp_handler)

    runner = web.AppRunner(app)
    await runner.setup()
    site = web.TCPSite(runner, host, port)
    print(f"Server starting on http://{host}:{port}")
    await site.start()

    # Keep the server running
    try:
        # Check if we're in test mode
        if os.environ.get('SAILFIN_TEST_MODE'):
            print("Test mode detected, server will exit after 2 seconds...")
            await asyncio.sleep(2)
            print("Server shutting down (test mode)...")
        else:
            await asyncio.Future()  # Run forever
    except KeyboardInterrupt:
        print("Server shutting down...")
    finally:
        await runner.cleanup()
        await http.close()
